//
//  WeatherManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 21/11/23.
//

import Foundation

@Observable class WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=36edc21645688e507b7210dd0250ffd5&units=metric"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String) {
        
        //Four steps to Networking
        
        
        // 1. Create a URL
        
        if let url = URL(string: urlString) {
            
            // 2. Create a URL Session
            
            let session = URLSession(configuration: .default)
            
            // 3. Give the Session a task
            let task =  session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            // 4. Start the Task
            
            task.resume()
            
        }
        
        func handle(data: Data?, response: URLResponse?, error: Error?) {
            
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                let dataString = String(data: safeData, encoding: .utf8)
                print(dataString)
            }
            
        }
        
        
        
        
    }
    
    
}
