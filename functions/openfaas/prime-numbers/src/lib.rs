fn prime_numbers_calc(max: usize) -> Vec<usize> {
    let mut result: Vec<usize> = Vec::new();
    if max >= 2 {
        result.push(2)
    }
    for i in (3..max + 1).step_by(2) {
        let stop: usize = (i as f64).sqrt() as usize + 1;
        let mut status: bool = true;

        for j in (3..stop).step_by(2) {
            if i % j == 0 {
                status = false;
                break;
            }
        }
        if status {
            result.push(i)
        }
    }
    result
}
pub fn handle(_req : String) -> String {
    let prime_numbers_result = prime_numbers_calc(100);
    format!("The value is: {:?}", prime_numbers_result).to_string()
}