//
//  Extras.swift
//  DemoApp
//
//  Created by Prithvi Raj on 12/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import Foundation

let API_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitudes!)&lon=\(longitudes!)&appid=7c609f73c5df2dff2f32e3e3cc33cd23"
let FORECAST_API_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(latitudes!)&lon=\(longitudes!)&cnt=8&appid=7c609f73c5df2dff2f32e3e3cc33cd23"

typealias DownloadComplete = () -> ()
