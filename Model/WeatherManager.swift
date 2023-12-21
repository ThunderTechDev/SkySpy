//
//  WeatherManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 21/11/23.
//

import SwiftUI

@Observable class WeatherManager {
    
    var isDaytime: Bool = true
    var currentWeather: WeatherModel?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=36edc21645688e507b7210dd0250ffd5&units=metric"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    
    
    
    func performRequest (urlString: String) {

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    _ = self.parseJSON(weatherData: safeData)
                    
                }
            }
            task.resume()
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
