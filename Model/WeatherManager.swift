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
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=36edc21645688e507b7210dd0250ffd51&units=metric"
    
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
            let dt = decodedData.dt
            let timezone = decodedData.timezone
            
            
            updateDaytimeStatus(sunrise: sunrise, sunset: sunset, dt: dt, timezoneOffset: timezone)
            
            print("El código de imagen es \(id)")
            print(name)
            print(temp)
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            DispatchQueue.main.async {
                self.currentWeather = weather
            }
            return weather
        } catch {
            cityError = true
            print("Aquí imprimo el error \(error)")
            return nil
        }
    }
    
    
    func updateDaytimeStatus(sunrise: Double, sunset: Double, dt: Double, timezoneOffset: Int) {
        let currentDate = Date(timeIntervalSince1970: dt + Double(timezoneOffset))
        let localSunriseDate = Date(timeIntervalSince1970: sunrise + Double(timezoneOffset))
        let localSunsetDate = Date(timeIntervalSince1970: sunset + Double(timezoneOffset))
        
        print("Local Date Time: \(currentDate)")
        print("Local Sunrise Time: \(localSunriseDate)")
        print("Local Sunset Time: \(localSunsetDate)")
        
        isDaytime = currentDate >= localSunriseDate && currentDate <= localSunsetDate
        print("Is Daytime?: \(isDaytime)")
    }
    
}
