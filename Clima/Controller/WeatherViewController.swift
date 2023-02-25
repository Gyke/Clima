//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButtonView: UIButton!
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        doSearch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
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
    
    func doSearch() {
        searchTextField.endEditing(true)
        let appid = "6d2d8b70eee2e0fb60d968d3d7de6392"
        var weathrManager = WeatherManager(appID: appid, cityName: searchTextField.text!)
        weathrManager.delegate = self

        weathrManager.fetch()
        searchTextField.text = ""
        searchButtonView.isEnabled = false
    }

}

