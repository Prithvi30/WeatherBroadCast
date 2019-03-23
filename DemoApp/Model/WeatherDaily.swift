//
//  WeatherDaily.swift
//  DemoApp
//
//  Created by Prithvi Raj on 12/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import Foundation
import SwiftyJSON


struct WeatherDaily: JSONDecodable {
    let day: String?
    let temperatureLow: Int?
    let temperatureHigh: Int?
    let description: WeatherImageRepresentation?
    
    init(json: JSON) {
        self.day = json[ResponseKeys.Daily.day].stringValue
        self.temperatureHigh = json[ResponseKeys.Daily.temperatureHigh].intValue
        self.temperatureLow = json[ResponseKeys.Daily.temperatureLow].intValue
        self.description = WeatherImageRepresentation(rawValue: json[ResponseKeys.Daily.description].stringValue)
    }
}
