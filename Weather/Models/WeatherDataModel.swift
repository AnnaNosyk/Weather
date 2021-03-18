//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Anna Nosyk on 18.03.2021.
//  Copyright © 2021 Anna Nosyk. All rights reserved.
//

import Foundation
struct WeatherDataModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}

struct Weather: Codable {
    let id: Int
}
