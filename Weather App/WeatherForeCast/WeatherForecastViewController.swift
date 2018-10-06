//
//  WeatherForeCastViewController.swift
//  Weather App
//
//  Created by Akio Ide on 03/10/2018.
//  Copyright © 2018 Akio Ide. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var weatherCellDatas: [WeatherCellData] = []
    @IBOutlet weak var forecastsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherCellDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creating some weather data:
        
        let data = weatherCellDatas[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherUITableViewCell
        cell.setWeatherCellData(weatherCellData: data)
        
        /*if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "WeatherCell")
        }*/
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.weatherCellDatas = createArray()
        self.forecastsTableView.dataSource = self
        self.forecastsTableView.delegate = self
        self.fetchUrl(url: "https://api.openweathermap.org/data/2.5/forecast/?q=Tampere,fi?&units=imperial&APPID=efc139b75863cc75e1bc6bbfa4b446f1")
        print(self.weatherCellDatas)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: self.doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        
        guard let weatherForecast = try? JSONDecoder().decode(WeatherForecast.self, from: data!) else {
            print("Error")
            return
        }

        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            self.weatherCellDatas = self.createForecastArray(weatherForecast: weatherForecast)
            print(self.weatherCellDatas)
            self.forecastsTableView.reloadData()
        })
    }
    
    func createArray() -> [WeatherCellData] {
        var dataList: [WeatherCellData] = []
        
        let weatherData1 = WeatherCellData(imageName: "01d", condition: "aurinkoinen", dateTime: "01/01/2018")
        let weatherData2 = WeatherCellData(imageName: "02d", condition: "aurinkoinen", dateTime: "01/01/2018")
        let weatherData3 = WeatherCellData(imageName: "03d", condition: "aurinkoinen", dateTime: "01/01/2018")
        let weatherData4 = WeatherCellData(imageName: "01d", condition: "aurinkoinen", dateTime: "01/01/2018")
        let weatherData5 = WeatherCellData(imageName: "02d", condition: "aurinkoinen", dateTime: "01/01/2018")
        
        dataList.append(weatherData1)
        dataList.append(weatherData2)
        dataList.append(weatherData3)
        dataList.append(weatherData4)
        dataList.append(weatherData5)
        return dataList
    }
    
    func createForecastArray(weatherForecast: WeatherForecast) -> [WeatherCellData] {
        var dataList: [WeatherCellData] = []
        
        for data in weatherForecast.list {
            let imageName = data.weather[0].icon
            let condition = data.weather[0].description + " " + String(format: "%.1f",self.fahrnheitToCelcius(fahrenheit: data.main.temp)) + " °C"
            
            let dataTime = data.dt_txt
            
            let weatherData = WeatherCellData(imageName: imageName, condition: condition, dateTime: dataTime!)
            dataList.append(weatherData)
        }
        return dataList
    }
    
    func fahrnheitToCelcius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * (5/9)
    }
    
}
