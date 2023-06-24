extern crate fake;
extern crate bytes;
extern crate serde;

use std::str;
use bytes::Bytes;
use fake::faker::{
    address::en::{BuildingNumber, CityName, CountryName, StreetName, ZipCode},
    internet::en::{UserAgent, Username, IP},
    name::raw::*,
};
use fake::locales::*;
use fake::Fake;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
struct Person {
    name: String,
    username: String,
    ip_address: String,
    user_agent: String,
    country: String,
    city: String,
    street_name: String,
    zip_code: String,
    building_number: String,
}

fn insert_record(person: &Person) {
    let client = reqwest::blocking::Client::new();
    let body = serde_json::to_string(&person).unwrap();
    let body_bytes = body.as_bytes();
    let body_bytes = Bytes::copy_from_slice(&body_bytes);

    client.post("http://192.168.85.153:3000/prest/public/users?_page_size=10&_page=1")
        .body(body_bytes)
        .header("Content-Type", "application/json")
        .send().unwrap();
}

pub fn handle(_req : String) -> String {
    let iterations = 1;
    for _ in 0..iterations {
        let name = Name(EN).fake();
        let username = Username().fake();
        let ip_address = IP().fake();
        let user_agent = UserAgent().fake();
        let country = CountryName().fake();
        let city = CityName().fake();
        let street_name = StreetName().fake();
        let zip_code = ZipCode().fake();
        let building_number = BuildingNumber().fake();
        let person = Person {
            name,
            username,
            ip_address,
            user_agent,
            country,
            city,
            street_name,
            zip_code,
            building_number,
        };
        insert_record(&person);
    }
    format!("Iterated {} times", iterations)
}