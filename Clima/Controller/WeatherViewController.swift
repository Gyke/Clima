//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButtonView: UIButton!
    
    var weatherManager: WeatherManager?
    let appid = "6d2d8b70eee2e0fb60d968d3d7de6392"

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        searchTextField.delegate = self
        
        weatherManager = WeatherManager(appID: appid)
        weatherManager?.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
 
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager!.fetch(by: lat, and: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        doSearch()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchButtonView.isEnabled = textField.text == "" ? false : true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doSearch()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Type something"
            return false
        }
        textField.placeholder = "Search"
        return true
    }
    
    func doSearch() {
        searchTextField.endEditing(true)

        weatherManager!.fetch(by: searchTextField.text!)
        searchTextField.text = ""
        searchButtonView.isEnabled = false
    }

}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        //                TODO: Всплывающее окно, где будет сказано, что название города введено неправильно
        print(error)
    }
}
