//
//  WeatherManager.swift
//  Clima
//
//  Created by Константин Стольников on 2023/02/25.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {

    let openWeatherURL = "https://api.openweathermap.org/data/2.5/weather"
    var appID: String
    var cityName: String
    var units: String
    
    init(appID: String, cityName: String, units: String = "metric") {
        self.appID = appID
        self.cityName = cityName
        self.units = units
    }
    
    func getFetchUrl() -> URL? {
        return URL(string: "\(openWeatherURL)?appid=\(appID)&units=\(units)&q=\(cityName)")
    }
    
    func createSession(with url: URL) -> URLSession {
        return URLSession(configuration: .default)
    }
    
    func startTask(for session: URLSession, with url: URL) {
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
//                TODO: Всплывающее окно, где будет сказано, что название города введено неправильно
                print("Got some erorr")
                print(error)
                return
            }
            if let data = data {
                parseJSON(weatherData: data)
            }
        }
        task.resume()
    }
    
    func fetch() {
        if let fetchURL = getFetchUrl() {
            let session = createSession(with: fetchURL)
            startTask(for: session, with: fetchURL)
        } else {
            print("Can not access to the server")
        }
    }
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather.first?.main)
        } catch {
            print(error)
        }

    }
}
