//
//  WeatherUITableViewCell.swift
//  Weather App
//
//  Created by Akio Ide on 06/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import UIKit

class WeatherUITableViewCell: UITableViewCell {
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    func setWeatherCellData(weatherCellData: WeatherCellData) {
        self.weatherImageView.image = weatherCellData.image
        self.conditionLabel.text = weatherCellData.condition
        self.dateTimeLabel.text = weatherCellData.dateTime
    }
}
