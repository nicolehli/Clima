//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    // 1 Implementing a Delegate
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "12da2f6205f3976bb4787383dd8a69ec"
    

    //TODO: Declare instance variables here
    // 2 Implementing a Delegate create object
    let locationManager = CLLocationManager()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        // 3 Implementing a Delegate to self
        locationManager.delegate = self  //delegate for Receiving Data from Location Services
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization() // asking for loc permission
        locationManager.startUpdatingLocation() // async call
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
                // print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            } else  {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Error"
            }
        }
        
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON) {
        let tempJSON = json["main"]["temp"]
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    // 4 Implementing a Delegate - we can now use delegate methods
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // last latlon is the most accurate location
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
        
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


