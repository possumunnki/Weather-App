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
    var cityNames: [String] = []
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController = segue.destination as! AddCityViewController
        destViewController.cityNames = cityNames
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadList()
        self.tableView.reloadData()
        
    }
    override func tableView(_ tableVew: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //avoids user to delete "Use GPS" -row
        if indexPath.row == 0 {
            let notAbleButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "Not able to delete this") {(action, index) -> Void in
                
                self.tableView.reloadData()
            }
            notAbleButton.backgroundColor = UIColor.darkGray
            return [notAbleButton]
        //user is able to delete the other row by swiping left
        } else {
            let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "DELETE") {(action, index) -> Void in
                self.cityNames.remove(at: indexPath.row)
                self.saveList()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }
            deleteButton.backgroundColor = UIColor.red
            
            return [deleteButton]
        }
    }
    
    func saveList() {
        let defaultDB = UserDefaults.standard
        let cities = CityList(cities: self.cityNames)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: cities, requiringSecureCoding: false)
            defaultDB.set(data, forKey: "list")
            defaultDB.synchronize()
            NSLog("Saved")
        } catch {
            NSLog("Could not save!")
        }
    }
    func loadList() {
        let defaultDB = UserDefaults.standard
        // checks that data of city list exists
        if let data = defaultDB.object(forKey: "list") as! Data? {
            do {
                let cities = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! CityList
                self.cityNames = cities.cities
                NSLog("Loaded")
            } catch {
                NSLog("Could not load!")
                self.cityNames = ["Use GPS","Tampere","Turku","Helsinki"]
            }
            // if not found, creates default list
        } else {
            self.cityNames = ["Use GPS","Tampere","Turku","Helsinki"]
        }
        
    }
}
