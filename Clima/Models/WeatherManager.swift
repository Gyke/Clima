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
    
    var delegate: WeatherManagerDelegate?
    
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
                delegate?.didFailWithError(error: error)
                return
            }
            if let data = data {
                if let weather = parseJSON(data) {
                    delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        task.resume()
    }
    
    func fetch() {
        if let fetchURL = getFetchUrl() {
            let session = createSession(with: fetchURL)
            startTask(for: session, with: fetchURL)
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let weather = WeatherModel(conditionId: decodedData.weather.first!.id, cityName: decodedData.name, temperature: decodedData.main.temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
