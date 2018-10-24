//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Akio Ide on 05/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let main: WeatherMain
    let weather: [WeatherData]
    let dt_txt: String?
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case weather = "weather"
        case dt_txt = "dt_txt"
    }
    
}

struct WeatherMain: Decodable {
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}

struct WeatherData: Decodable {
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}
