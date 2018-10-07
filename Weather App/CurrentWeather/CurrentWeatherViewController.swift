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
    var cityName = "Tampere"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchUrl(url: "https://api.openweathermap.org/data/2.5/weather?q=" + cityName + ",fi?&units=imperial&APPID=efc139b75863cc75e1bc6bbfa4b446f1")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            print(currentWeather)
            self.setUI(weather: currentWeather)
        })
    }
    
    func setUI(weather: CurrentWeather) {
        print("city name:", self.cityName)
        self.cityNameLabel.text = self.cityName
        print("Image:",  weather.weather[0].icon)
        let imageName = weather.weather[0].icon + ".png"
        self.weatherImageView.image = UIImage(named: imageName)
        print("temp:", weather.main.temp)
        let celcius = fahrnheitToCelcius(fahrenheit: weather.main.temp)
        self.tempLabel.text = String(format: "%.1f",celcius) + " °C"
        
    }
    
    func fahrnheitToCelcius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * (5/9)
    }
    
}
