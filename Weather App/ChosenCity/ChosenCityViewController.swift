//
//  ChosenCityViewController.swift
//  Weather App
//
//  Created by Akio Ide on 03/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import UIKit

class ChosenCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cityTableView: UITableView!
    
    var cityNames: [String] = []
    var editScreen: EditCitiesViewController?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data: String = cityNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityUITableViewCell
        cell.setUI(cityName: data)
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cityNames = DataHandler.loadCityList()
        cityTableView.reloadData()
        
    }
    
    //Passes list of city to the EditCityViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController = segue.destination as! EditCitiesViewController
        self.editScreen = destViewController
        self.editScreen?.cityNames = self.cityNames
    }
    
    private func tableView(_ tableView: UITableView, commit eiditingStyle: UITableViewStyle, forRowAt indexPath: IndexPath) {
        NSLog(String(indexPath.row))
    }

}
