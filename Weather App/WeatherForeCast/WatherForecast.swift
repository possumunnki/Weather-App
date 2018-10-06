//
//  WatherForecast.swift
//  Weather App
//
//  Created by Akio Ide on 06/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation


struct WeatherForecast: Decodable {
    
    let cod: Int
    let message: String
    let cnt: Int
    let list: [WeatherData]
    
}
