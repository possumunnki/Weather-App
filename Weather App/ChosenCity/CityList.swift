//
//  CityList.swift
//  Weather App
//
//  Created by Akio Ide on 23/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
class CityList: NSObject, NSCoding {
    var cities: [String] = []
    init(cities: [String]) {
        self.cities = cities
    }
    
    required init?(coder decoder: NSCoder) {
        cities = decoder.decodeObject(forKey: "cityList") as! [String]
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(cities, forKey: "cityList")
    }
    
}
