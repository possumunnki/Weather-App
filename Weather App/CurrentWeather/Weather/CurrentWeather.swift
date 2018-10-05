//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Akio Ide on 05/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
struct CurrentWeather: Codable {
    let coord: Coord
    let weather: Weather
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
}
