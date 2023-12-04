//
//  WeatherModel.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 4/12/23.
//

import Foundation

@Observable class WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    init(conditionId: Int, cityName: String, temperature: Double) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
    }

    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "thunderstorm.png"
        case 300...321:
            return "drizzle.png"
        case 500...531:
            return "rain.png"
        case 600...622:
            return "snow.png"
        case 700...781:
            return "fog.png"
        case 800:
            return "sun.png"
        case 801...804:
            return "few clouds.png"
        default:
            return "cloud.png"
            
        }
    }
    
}
