extern crate whatlang;
use whatlang::detect;

pub fn handle(_req : String) -> String {
    let sentence = "The quick brown fox jumps over the lazy dog";
    let language = detect(&sentence).unwrap().lang();
    format!("<i>{sentence}</i> = <b>{language}</b>")
}