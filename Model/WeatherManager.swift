//
//  WeatherManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 21/11/23.
//

import SwiftUI

@Observable class WeatherManager {
    
    var cityName: String = ""
    var placeHolder = "Enter the name of the city"
    var currentCity = "City"
    var isDaytime: Bool = true
    var cityError = false
    var currentWeather: WeatherModel?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=36edc21645688e507b7210dd0250ffd5&units=metric"
    
    func fetchWeather(cityName: String) async -> Bool {
        let urlString = "\(weatherURL)&q=\(cityName)"
        return await performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String) async -> Bool {
        guard let url = URL(string: urlString) else { return false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return parseJSON(weatherData: data) != nil
        } catch {
            return false
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let sunrise = decodedData.sys.sunrise
            let sunset = decodedData.sys.sunset
            
            let sunriseDateString = dateFormatter(unixDate: sunrise)
            let sunsetDateString = dateFormatter(unixDate: sunset)
            updateDaytimeStatus(sunrise: decodedData.sys.sunrise, sunset: decodedData.sys.sunset)
            
            print(name)
            print(id)
            print(temp)
            print("The sunrise hour is \(sunriseDateString)")
            print("The sunset hour is \(sunsetDateString)")
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            DispatchQueue.main.async {
                self.currentWeather = weather
            }
            return weather
        } catch {
            cityError = true
            print(error)
            return nil
        }
    }
    
    
    func dateFormatter(unixDate: Double) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium

        let formattedDate = Date(timeIntervalSince1970: unixDate)
        

        let conversedDateToString = dateFormatter.string(from: formattedDate)
        
        return conversedDateToString
        
    }
    
    func updateDaytimeStatus(sunrise: Double, sunset: Double) {
            let currentDate = Date()
            let sunriseDate = Date(timeIntervalSince1970: sunrise)
            let sunsetDate = Date(timeIntervalSince1970: sunset)

            // Comprobar si la hora actual está entre la salida y la puesta del sol
            if currentDate >= sunriseDate && currentDate <= sunsetDate {
                isDaytime = true
                print("Is Daytime?: \(isDaytime)")
            } else {
                isDaytime = false
                print("Is Daytime?: \(isDaytime)")
            }
        }
    


  
}
