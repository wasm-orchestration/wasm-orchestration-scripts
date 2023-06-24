package main

import (
	"fmt"
	"math"
	"net/http"
	"strconv"

	spinhttp "github.com/fermyon/spin/sdk/go/http"
)

func floatOperation(floatNum float64) (float64, float64, float64) {
	resultSin := math.Sin(floatNum)
	resultCos := math.Cos(floatNum)
	resultSqrt := math.Sqrt(floatNum)
	return resultSin, resultCos, resultSqrt
}

func init() {
	spinhttp.Handle(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/plain")
		q_number := r.URL.Query().Get("n")
		number, err := strconv.ParseFloat(q_number, 64)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			fmt.Fprintln(w, "Cannot parse n query string parameter")
			return
		}
		resultSin, resultCos, resultSqrt := floatOperation(number)
		fmt.Fprintln(w, fmt.Sprintf("Number: %f\nSin: %f\nCos: %f\nSqrt: %f", number, resultSin, resultCos, resultSqrt))
	})
}

func main() {}
