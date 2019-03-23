//
//  WeatherData.swift
//  DemoApp
//
//  Created by Prithvi Raj on 12/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let id, cod: Int
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
    let sys: Sys
    let dt: Int
    let coord: Coord
    let clouds: Clouds
    let base: String
    let visibility: Int
}

struct Clouds: Codable {
    let all: Int
}

struct Coord: Codable {
    let lat, lon: Double
}

struct Main: Codable {
    let pressure: Int
    let tempMin: Double
    let humidity: Int
    let temp, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case pressure
        case tempMin = "temp_min"
        case humidity, temp
        case tempMax = "temp_max"
    }
}

struct Sys: Codable {
    let id, sunset: Int
    let country: String
    let sunrise, type: Int
    let message: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
    let main, icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}



class WeatherData {
    
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    var humidity: Int = 0
    var Pressure: Int = 0
    var lon: Double = 0
    var lat: Double = 0
    var visibility: Int = 0
    var speed: Double = 0.0
    var all: Int = 0
    var Desc: String = ""
    
    func updateWeatherIcon(condition: Int) -> String {
        switch (condition) {
        case 0...300 :
            return "storm1"
        case 301...500 :
            return "light_rain"
        case 501...600 :
            return "much_rain"
        case 601...700 :
            return "snow1"
        case 701...771 :
            return "fog"
        case 772...799 :
            return "storm2"
        case 800 :
            return "sunny"
        case 801...804 :
            return "cloudy"
        case 900...903, 905...1000  :
            return "storm2"
        case 903 :
            return "snow2"
        case 904 :
            return "sunny"
        default :
            return "dont_know"
        }
    }
    
}
