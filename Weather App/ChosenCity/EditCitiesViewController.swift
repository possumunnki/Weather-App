//
//  EditCitiesViewController.swift
//  Weather App
//
//  Created by Akio Ide on 11/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
import UIKit
class EditCitiesViewController:UITableViewController {
    var cityNames = ["Use GPS","Tampere","Turku","Helsinki"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data: String = cityNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell") as! EditCitiesUITableViewCell
        cell.setUI(cityName: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit eiditingStyle: UITableViewStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            self.cityNames.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableVew: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.row == 0 {
            let notAbleButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "Not able to delete this") {(action, index) -> Void in
                
                self.tableView.reloadData()
            }
            notAbleButton.backgroundColor = UIColor.darkGray
            return [notAbleButton]
            
        } else {
            let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "DELETE") {(action, index) -> Void in
                self.cityNames.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }
            deleteButton.backgroundColor = UIColor.red
            return [deleteButton]
        }

        
    }
}
