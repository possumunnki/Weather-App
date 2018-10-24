//
//  DataHandler.swift
//  Weather App
//
//  Created by Akio Ide on 24/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation

class DataHandler {
    static func printSomething() {
        print("This is maybe working?")
    }
    
    static func saveCityList(cityList: [String]) {
        let defaultDB = UserDefaults.standard
        let cities:[String] = cityList
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cities, requiringSecureCoding: false)
            defaultDB.set(data, forKey: "cityList")
            defaultDB.synchronize()
            NSLog("Saved")
        } catch {
            NSLog("Could not save cityNames!")
        }
    }
    
    static func loadCityList() -> [String]{
        var cityNames: [String] = []
        let defaultDB = UserDefaults.standard
        // checks that data of city list exists
        if let data = defaultDB.object(forKey: "cityList") as! Data? {
            do {
                let cityList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [String]
                cityNames = cityList
                NSLog("Loaded")
            } catch {
                NSLog("Could not load!")
                cityNames = ["Use GPS","Tampere","Turku","Helsinki"]
            }
            // if not found, creates default list
        } else {
            cityNames = ["Use GPS","Tampere","Turku","Helsinki"]
        }
        return cityNames
    }
    
    static func saveCurrentCity(currentCity: String) {
        let defaultDB = UserDefaults.standard
        let city = currentCity
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: city, requiringSecureCoding: false)
            defaultDB.set(data, forKey: "currentCity")
            defaultDB.synchronize()
            NSLog("Saved Current City")
        } catch {
            NSLog("Could not save currentCity!")
        }
    }
    
    static func loadCurrentCity() -> String{
        var currentCity: String = ""
        let defaultDB = UserDefaults.standard
        // checks that data of city list exists
        if let data = defaultDB.object(forKey: "currentCity") as! Data? {
            do {
                let city = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! String
                currentCity = city
                NSLog("currentCity Loaded")
            } catch {
                NSLog("Could not load currentCity!")
                currentCity = "Tampere"
            }
            // if not found, creates default list
        } else {
            currentCity = "Tampere"
        }
        return currentCity
    }
}
