//
//  NetworkManager.swift
//  Weather
//
//  Created by Anna Nosyk on 04.03.2021.
//  Copyright © 2021 Anna Nosyk. All rights reserved.
//

import Foundation
import CoreLocation



class NetworkManager {
    enum RequetType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    var onCompletion: ((CurrentWeatherModel) -> Void)?
    
    func featchWeather(forRequesType requestType: RequetType) {
        var urlStr = ""
        switch requestType {
        case .cityName(let city):
          urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude) :
            urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlStr)
    }

    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                                }
            }
        }
        
        task.resume()
    }
    
    // getting data
    fileprivate func parseJSON(withData data: Data) -> CurrentWeatherModel? {
        let decoder = JSONDecoder()
        do {
       let currenWeatherData = try decoder.decode(WeatherDataModel.self, from: data)
           
            guard let currentWeather = CurrentWeatherModel(weatherDataModel: currenWeatherData) else { return nil
                
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
        
}
