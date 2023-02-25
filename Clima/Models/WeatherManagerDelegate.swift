//
//  WeatherDelegate.swift
//  Clima
//
//  Created by Константин Стольников on 2023/02/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
