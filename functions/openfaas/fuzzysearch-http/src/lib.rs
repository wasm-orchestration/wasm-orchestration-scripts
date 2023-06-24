extern crate simsearch;
extern crate reqwest;

use simsearch::SimSearch;
use std::str;


fn search(file_content: &str, search_pattern: String) -> Vec<u32> {
    let mut counter = 0;
    let mut engine: SimSearch<u32> = SimSearch::new();

    for line in file_content.split("\n") {
        engine.insert(counter, &line);
        counter += 1;
    }

    let mut results: Vec<u32> = engine.search(&search_pattern);
    results.sort();
    return results;
}

fn fetch_html(url: &str) -> Result<String, reqwest::Error> {
    let http_response = reqwest::blocking::get(url)?;
    let html_body = http_response.text()?;
    return Ok(html_body);
}


pub fn handle(_req : String) -> String {
    let search_keyword = "Hamlet".to_string();
    let text = fetch_html("https://static.mrezhi.net/wasi-sample-files/hamlet.txt").unwrap();
    let matches = search(&text, search_keyword);
    format!("{:?}", matches)
}