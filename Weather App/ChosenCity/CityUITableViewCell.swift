//
//  CityUITableViewCell.swift
//  Weather App
//
//  Created by Akio Ide on 10/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
import UIKit
class CityUITableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    func setUI(cityName: String) {
        self.cityLabel.text = cityName
    }
}
