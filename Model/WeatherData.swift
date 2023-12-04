//
//  WeatherData.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 30/11/23.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
