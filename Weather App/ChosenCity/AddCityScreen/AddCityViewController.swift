//
//  AddCityViewController.swift
//  Weather App
//
//  Created by Akio Ide on 24/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
import UIKit

class AddCityViewController: UIViewController {
    var cityNames: [String] = []
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBAction func addPressed(_ sender: Any) {
        if cityNameTextField.text != "" {
            cityNames.append(cityNameTextField.text!)
            saveList()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveList() {
        let defaultDB = UserDefaults.standard
        let cities = CityList(cities: self.cityNames)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cities, requiringSecureCoding: false)
            defaultDB.set(data, forKey: "list")
            defaultDB.synchronize()
            NSLog("Saved")
        } catch {
            NSLog("Could not save!")
        }
    }
    
    
}
