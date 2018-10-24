//
//  ChosenCityViewController.swift
//  Weather App
//
//  Created by Akio Ide on 03/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import UIKit
import CoreLocation
class ChosenCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var cityTableView: UITableView!
    
    var cityNames: [String] = []
    var editScreen: EditCitiesViewController?
    var locationManager: CLLocationManager?
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
        self.locationManager = CLLocationManager()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //not working atm.
            //fetchLocation()
        } else {
            DataHandler.saveCurrentCity(currentCity: cityNames[indexPath.row])
        }
        
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
    
    
    
    func fetchLocation() {
        
        self.locationManager!.delegate = self
        self.locationManager!.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager!.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        self.fetchCurrentCity(location: userLocation)
        manager.stopUpdatingLocation()
    }
    
    func fetchCurrentCity(location: CLLocation) {
        var address: String = "somewhere"
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                if pm.locality != nil {
                    address = pm.locality!
                    DataHandler.saveCurrentCity(currentCity: address)
                    print(address)
                }
            }
        })
        
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + (error.localizedDescription))
    }

}
