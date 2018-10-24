//
//  CurrentWeatherViewController.swift
//  Weather App
//
//  Created by Akio Ide on 03/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    var cityName = ""
    var weatherFetcher = WeatherFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if cityName != DataHandler.loadCurrentCity() {
            cityName = DataHandler.loadCurrentCity()
            fetchUrl(url: "https://api.openweathermap.org/data/2.5/weather?q=" + cityName + ",fi?&units=imperial&APPID=efc139b75863cc75e1bc6bbfa4b446f1")
            NSLog("FETCHING")
        }
    }
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        guard let currentWeather = try? JSONDecoder().decode(CurrentWeather.self, from: data!) else {
            print("Error")
            return
        }
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            //NSLog(resstr!)
            self.setUI(weather: currentWeather)
        })
    }
    
    func setUI(weather: CurrentWeather) {
        //sets city name on label
        self.cityNameLabel.text = self.cityName
        let imageName = weather.weather[0].icon + ".png"
        self.weatherImageView.image = UIImage(named: imageName)
        //converts fahrenheit to celcius and sets on temp label
        let celcius = fahrnheitToCelcius(fahrenheit: weather.main.temp)
        self.tempLabel.text = String(format: "%.1f",celcius) + " °C"
        
    }
    
    func fahrnheitToCelcius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * (5/9)
    }
    
}
