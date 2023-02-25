//
//  WeatherData.swift
//  Clima
//
//  Created by Константин Стольников on 2023/02/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name       : String
    let weather    : [Weather]
    let main       : Main
    let visibility : Double
    let wind       : Wind
}

struct Weather: Decodable {
    let main        : String
    let description : String
    let icon        : String
}

struct Main: Decodable {
    let temp       : Double
    let feels_like : Double
    let pressure   : Double
    let humidity   : Double
}

struct Wind: Decodable {
    let speed : Double
    let deg   : Double
}
