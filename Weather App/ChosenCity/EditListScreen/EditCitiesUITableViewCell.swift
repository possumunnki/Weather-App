//
//  EditCitiesUITableViewCell1.swift
//  Weather App
//
//  Created by Akio Ide on 11/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
import UIKit
class EditCitiesUITableViewCell: UITableViewCell{
    
    @IBOutlet weak var cityLabel: UILabel!
    func setUI(cityName: String) {
        self.cityLabel.text = cityName
    }
}
