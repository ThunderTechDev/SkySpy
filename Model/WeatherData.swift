//
//  WeatherData.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 29/11/23.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
}

struct Main: Decodable {
    let humidity: Double
    
}
