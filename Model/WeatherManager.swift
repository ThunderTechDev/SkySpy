//
//  WeatherManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 21/11/23.
//

import SwiftUI

@Observable class WeatherManager {
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=36edc21645688e507b7210dd0250ffd5&units=metric"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        //print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String) {
        
        //Four steps to Networking
        
        
        // 1. Create a URL
        
        if let url = URL(string: urlString) {
            
            // 2. Create a URL Session
            
            let session = URLSession(configuration: .default)
            
            // 3. Give the Session a task
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                    
                }
            }
            
            // 4. Start the Task
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            print(name)
            print(id)
            print(temp)
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather)
        } catch {
            print(error)
        }
        
    }
    
    


    
}
