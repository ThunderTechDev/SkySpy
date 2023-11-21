//
//  WeatherManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 21/11/23.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=36edc21645688e507b7210dd0250ffd5&units=metric"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
    
}
