//
//  CurrentWeatherViewController.swift
//  Weather App
//
//  Created by Akio Ide on 03/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchUrl(url: "https://api.openweathermap.org/data/2.5/weather?q=Tampere,fi?&units=imperial&APPID=efc139b75863cc75e1bc6bbfa4b446f1")
        let weatherIcon = UIImage(named: "clear.png")
        self.imageView.image = weatherIcon
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
        let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        guard let currentWeather = try? JSONDecoder().decode(CurrentWeather.self, from: data!) else {
            print("Error")
            return
        }
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            //NSLog(resstr!)
            print(currentWeather)
        })
    }
    
}
