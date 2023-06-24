package function

import (
	"fmt"
	"math/rand"
	"net/http"
	"strconv"
	"time"

	"gonum.org/v1/gonum/mat"
)

func generateRandomMatrix(randomInstance *rand.Rand, rows int, columns int) *mat.Dense {

	data := make([]float64, rows*columns)
	for i := range data {
		data[i] = randomInstance.NormFloat64()
	}
	return mat.NewDense(rows, columns, data)
}

func Handle(w http.ResponseWriter, r *http.Request) {

	w.Header().Set("Content-Type", "text/plain; charset=\"UTF-8\"")
	unknowns, err := strconv.Atoi(r.URL.Query().Get("unknowns"))
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		fmt.Fprintln(w, "Cannot parse unknowns query string parameter")
		return
	}
	seed := rand.NewSource(time.Now().UnixNano())
	randomInstance := rand.New(seed)
	matrixResult := mat.NewDense(unknowns, 1, nil)
	a := generateRandomMatrix(randomInstance, unknowns, unknowns)
	b := generateRandomMatrix(randomInstance, unknowns, 1)
	matrixResult.Solve(a, b)
	formatted := mat.Formatted(matrixResult, mat.Prefix(""), mat.Squeeze())
	fmt.Fprintln(w, formatted)
}
