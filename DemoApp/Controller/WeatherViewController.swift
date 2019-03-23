//
//  WeatherViewController.swift
//  DemoApp
//
//  Created by Prithvi Raj on 12/02/19.
//  Copyright © 2019 Prithvi Raj. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

public var latitudes: Double?
public var longitudes: Double?

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    var forecastArray = [ForecastWeather]()
    var currentLocation: CLLocation!
    var currentWeather: WeatherData!

    @IBOutlet weak var CityName: UILabel!
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "2c3e7c4012dd99c628846c33c6b1e4ad"


    let locationManager = CLLocationManager()
    
    let weatherData = WeatherData()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(WeatherViewController.tapFunction))
        tempLabel.isUserInteractionEnabled = true
        tempLabel.addGestureRecognizer(tap)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        
        tableView.rowHeight = 70
        
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        downloadForecastWeather {
            print("DATA DOWNLOADED")
        }
    }
    
    
   // Swift 4 method for json parsing
    
    func weatherDataa(url: String, parameters: [String: String]) {
        guard let url = URL(string: "\(WEATHER_URL)+\(APP_ID)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(Welcome.self, from:
                    dataResponse) //Decode JSON Response Data
                print(model)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func getWeatherData(url: String, parameters: [String: String]) {
        AF.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(response.result.error!))")
                self.title = "Connection Issues"
            }
            
          
        }
    }
    
    
    func downloadForecastWeather(completed: @escaping DownloadComplete) {
        AF.request(FORECAST_API_URL).responseJSON { (response) in
            let result = response.result
            
           // print(response.response)
            
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                
                
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>] {
                    
                    print(list)
                    
                    for item in list {
                        
                        let forecast = ForecastWeather(weatherDict: item)
                        self.forecastArray.append(forecast)
                        
                        print(forecast)
                    }
                   self.forecastArray.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    

    
    func updateWeatherData(json: JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            
            weatherData.temperature = Int(tempResult - 273.15)
            weatherData.city = json["name"].stringValue
            weatherData.condition = json["weather"][0]["id"].intValue
            weatherData.Desc = json["weather"][0]["description"].stringValue
            //weatherData.lat = json["coord"][0]["lat"].double!
            
            
            UserDefaults.standard.set("\(weatherData.city)", forKey: "Key") //setObject

            
            
            print("This is latitude \(weatherData.humidity)")
            
            weatherData.weatherIconName = weatherData.updateWeatherIcon(condition: weatherData.condition)
            updateUIWithWeatherData()
        }
        
        let humidity = json["main"]["humidity"].intValue
        weatherData.humidity = humidity
        print(weatherData.humidity)
        
        let locations = json["coord"]["lat"].double
        weatherData.lat = locations!
        print(weatherData.lat)
        
        let lon = json["coord"]["lon"].double
        weatherData.lon = lon!
        print(weatherData.lon)
        
        
        let press = json["main"]["pressure"].intValue
        weatherData.Pressure = press
        print(weatherData.Pressure)
        
        
        let wind = json["wind"]["speed"].double
        weatherData.speed = wind!
        print(weatherData.speed)
        
        let cloud = json["clouds"]["all"].intValue
        weatherData.all = cloud
        print(weatherData.all)
        
        longitudes = weatherData.lon
        latitudes = weatherData.lat
        
        UserDefaults.standard.set("\(weatherData.city)", forKey: "Key") //setObject
        UserDefaults.standard.set("\(weatherData.humidity)", forKey: "hum") //setObject
        UserDefaults.standard.set("\(weatherData.Pressure)", forKey: "Pre") //setObject
        UserDefaults.standard.set("\(weatherData.speed)", forKey: "Speed") //setObject
        UserDefaults.standard.set("\(weatherData.all)", forKey: "all") //setObject
        UserDefaults.standard.set("\(weatherData.Desc)", forKey: "des") //setObject
        UserDefaults.standard.set("\(weatherData.temperature)", forKey: "tempß")
        
}

    @IBAction func ProfileTapped(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VC") as! SecondVC
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func updateUIWithWeatherData() {
        self.title = UserDefaults.standard.string(forKey: "Key")
        
        CityName.text = "\(weatherData.city)"
        tempLabel.text = "\(weatherData.temperature)°"
        weatherIcon.image = UIImage(named: weatherData.weatherIconName)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)" )
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params: [String:String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
            
         //   getWeatherData(url: FORECAST_API_URL, parameters: params)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.title = "Location unavailable"
    }
    
    func userEnteredANewCityName(city: String) {
        
        let params: [String:String] = ["q": city, "appid": APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
        //weatherDataa(url: WEATHER_URL, parameters: params)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
}


extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        
        cell!.configureCell(forecastData: forecastArray[indexPath.row])
        
        return cell!
    }
    
    
}
