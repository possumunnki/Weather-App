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
        let cities = CityList(cities: cityList)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cities, requiringSecureCoding: false)
            defaultDB.set(data, forKey: "list")
            defaultDB.synchronize()
            NSLog("Saved")
        } catch {
            NSLog("Could not save!")
        }
    }
    
    static func loadCityList() -> [String]{
        var cityNames: [String] = []
        let defaultDB = UserDefaults.standard
        // checks that data of city list exists
        if let data = defaultDB.object(forKey: "list") as! Data? {
            do {
                let cities = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! CityList
                cityNames = cities.cities
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
}
