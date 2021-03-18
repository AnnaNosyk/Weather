//
//  ViewController.swift
//  Weather
//
//  Created by Anna Nosyk on 04/03/2021.
//  Copyright © 2021 Anna Nosyk. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    var networkManager = NetworkManager()
    // for location of user
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert){ [unowned self] city in
            self.networkManager.featchWeather(forRequesType: .cityName(city: city))
        }
    }
    
    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting data
        networkManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterFace(weather: currentWeather)
        }
        
        //user location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
     
    }
    //updating interface
    func updateInterFace(weather: CurrentWeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeString + " ºC"
            self.pressureLabel.text = weather.pressureString + " mm"
            self.humidityLabel.text = weather.humidityString + " %"
            self.weatherImage.image = UIImage(systemName: weather.systemIconName)
        }
    
    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
   
        networkManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterFace(weather: currentWeather)
        }
        
        //user location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
    }
    
    
}
// MARK - CLLocation Manager
extension ViewController: CLLocationManagerDelegate {
    //getting location user
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        //getting data from location
        networkManager.featchWeather(forRequesType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}




