//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Anna Nosyk on 08.03.2021.
//  Copyright © 2021 Anna Nosyk. All rights reserved.
//

import Foundation

struct CurrentWeatherModel {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    let feelsLike: Double
    var feelsLikeString: String {
        return String(format: "%.0f", feelsLike)
    }
    let pressure: Int
    var pressureString: String {
        return "\(pressure)"
    }
    let humidity: Int
    var humidityString: String {
        return "\(humidity)"
    }
    let conditionCode: Int
    var systemIconName: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    init?(weatherDataModel: WeatherDataModel) {
        cityName = weatherDataModel.name
        temperature = weatherDataModel.main.temp
        feelsLike = weatherDataModel.main.feelsLike
        pressure = weatherDataModel.main.pressure
        humidity = weatherDataModel.main.humidity
        conditionCode = weatherDataModel.weather.first!.id
    }
}
