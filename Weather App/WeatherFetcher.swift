//
//  WeatherFetcher.swift
//  Weather App
//
//  Created by Akio Ide on 09/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import Foundation
public class WeatherFetcher {
    let CURRENT_WEATHER = 1
    let FORECAST = 2
    var currentWeather: CurrentWeather?
    var forecast: WeatherForecast?
    

    
    func fetchCurrentWeather(cityName: String) -> CurrentWeather? {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=" + cityName + ",fi?&units=imperial&APPID=efc139b75863cc75e1bc6bbfa4b446f1"
        fetchUrl(url: url, type: self.CURRENT_WEATHER)
        
        return self.currentWeather
    }
    
    func fetchWeatherForecast(cityName: String) -> WeatherForecast {
        let url = "https://api.openweathermap.org/data/2.5/forecast/?q=" + cityName + ",fi?&units=imperial&APPID=efc139b75863cc75e1bc6bbfa4b446f1"
        fetchUrl(url: url, type: self.FORECAST)
        
        return self.forecast!
    }
    
    func fetchUrl(url : String, type: Int) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url : URL? = URL(string: url)
        if type == CURRENT_WEATHER {
            let task = session.dataTask(with: url!, completionHandler: doneFetchingWeather);
            task.resume();
        } else if type == FORECAST {
            let task = session.dataTask(with: url!, completionHandler: doneFetchingForecast);
            task.resume();
        }
        
        
        
    }
    
    func doneFetchingWeather(data: Data?, response: URLResponse?, error: Error?) {
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        guard let currentWeather = try? JSONDecoder().decode(CurrentWeather.self, from: data!) else {
            print("Error")
            return
        }
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            //NSLog(resstr!)
            self.currentWeather = currentWeather
        })
    }
    
    func doneFetchingForecast(data: Data?, response: URLResponse?, error: Error?) {
        
        guard let weatherForecast = try? JSONDecoder().decode(WeatherForecast.self, from: data!) else {
            print("Error")
            return
        }
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            self.forecast = weatherForecast
        })
    }
    
    func fahrnheitToCelcius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * (5/9)
    }
}
