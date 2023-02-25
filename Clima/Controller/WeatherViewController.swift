//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

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
    
    func doSearch() {
        searchTextField.endEditing(true)
        let appid = "6d2d8b70eee2e0fb60d968d3d7de6392"
        let weathrManager = WeatherManager(appID: appid, cityName: searchTextField.text!)

        weathrManager.fetch()
        searchTextField.text = ""
        searchButtonView.isEnabled = false
    }

}

