//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Nikhil Jaggi on 07/09/22.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    let minimumTemperature: Double
    let maximumTemperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var conditionImage: String {
        switch conditionId {
        case 200...232:
            return "thunder"
        case 300...321:
            return "rainy"
        case 500...531:
            return "rainy"
        case 600...622:
            return "snowy"
        case 701...781:
            return "rainy"
        case 800:
            return "sunny"
        case 801...804:
            return "thunder"
        default:
            return "sunny"
        }
    }
    
}
