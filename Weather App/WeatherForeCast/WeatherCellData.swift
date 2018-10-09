//
//  WeatherCellData.swift
//  Weather App
//
//  Created by Akio Ide on 06/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
import UIKit
class WeatherCellData {
    var image: UIImage
    var condition: String
    var dateTime: String
    
    init(imageName: String, condition: String, dateTime: String) {
        self.image = UIImage(named: imageName + ".png")!
        self.condition = condition
        self.dateTime = dateTime
    }
}
