//
//  WeatherModel.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 4/12/23.
//

import SwiftUI

class WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
   
    
    init(conditionId: Int, cityName: String, temperature: Double) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
    }

    
    var conditionName: String {
        let imageName: String
        switch conditionId {
        case 200...232:
            imageName = "thunderstorm"
        case 300...321:
            imageName = "drizzle"
        case 500...531:
            imageName = "rain"
        case 600...622:
            imageName = "snow"
        case 700...781:
            imageName = "fog"
        case 800:
            imageName = "sun"
        case 801...804:
            imageName = "few clouds"
        default:
            imageName = "cloud"
        }

       return imageName
    }
    
    
}
