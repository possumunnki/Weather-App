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
    let weatherData: [WeatherData]
    let city: String
    let dt_txt: String?
    
    enum CodingKeys: String, CodingKey {
        case main
        case weatherData = "weather"
        case city = "name"
        case dt_txt
    }
    
}

struct WeatherMain: Decodable {
    let temp: Double
}

struct WeatherData: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
