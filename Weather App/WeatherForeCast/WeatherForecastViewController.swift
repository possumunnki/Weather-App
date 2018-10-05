//
//  WeatherForeCastViewController.swift
//  Weather App
//
//  Created by Akio Ide on 03/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let data = ["Hattivatti", "Nuuskamuikkunen", "Muumipeikko", "Nipsu"]
    @IBOutlet weak var forecastsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "sample cell", for: indexPath)
        
        //cell.textLabel?.text = self.data[indexPath.row]
        let cell = UITableViewCell()
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.forecastsTableView.dataSource = self
        self.forecastsTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}