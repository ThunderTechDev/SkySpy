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
            let dt = decodedData.dt
            let timezone = decodedData.timezone
          
            
            updateDaytimeStatus(sunrise: sunrise, sunset: sunset, dt: dt, timezoneOffset: timezone)

            
            print(name)
            print(id)
            print(temp)
            
            
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
    
    
    func updateDaytimeStatus(sunrise: Double, sunset: Double, dt: Double, timezoneOffset: Int) {
        let currentDate = Date(timeIntervalSince1970: dt + Double(timezoneOffset))
        let localSunriseDate = Date(timeIntervalSince1970: sunrise + Double(timezoneOffset))
        let localSunsetDate = Date(timeIntervalSince1970: sunset + Double(timezoneOffset))


        // Imprimir las horas convertidas
        print("Local Date Time: \(currentDate)")
        print("Local Sunrise Time: \(localSunriseDate)")
        print("Local Sunset Time: \(localSunsetDate)")

        // Comprobar si la hora actual (en tu zona horaria local) está entre la salida y la puesta del sol (en la zona horaria de la ciudad)
        isDaytime = currentDate >= localSunriseDate && currentDate <= localSunsetDate
        print("Is Daytime?: \(isDaytime)")
    }

    

    // Asegúrate de que la función dateFormatter esté configurada correctamente para manejar la zona horaria.

    


  
}
