//
//  ContentView.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 9/10/23.
//



import SwiftUI

struct ContentView: View {
    
    @State private var cityName: String = ""
    @State private var currentCity = "City"
    @State private var placeHolder = "Enter the name of the city"
    @State private var weatherManager = WeatherManager()
    @FocusState private var isFirstResponder: Bool
    @Environment(\.colorScheme) var colorScheme
    
    
    
    var body: some View {
       
            ZStack {
                backgroundImage
                mainContent
            }
            .onTapGesture {
                isFirstResponder = false
            }.ignoresSafeArea(.keyboard, edges: .bottom)
    }

        var mainContent: some View {
            VStack {
                appTitle
                cityTextField
                temperatureDisplay
                cityNameDisplay
                imageArea
            }
            .padding(.horizontal, 30)
        }

      
    // MARK: - UI Components
    
    var backgroundImage: some View {
        Image(colorScheme == .dark ? "BackgroundSkySpyDark" : "BackgroundSkySpy")
            .resizable(resizingMode: .stretch)
            .edgesIgnoringSafeArea(.all)
    }
    
    var appTitle: some View {
        VStack {
            Spacer().frame(height: 10)
            ZStack {
                Text("SkySpy")
                    .font(Font.custom("SF Compact Rounded", size: 64.0))
                    .blur(radius: 3.0)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                Text("SkySpy")
                    .font(Font.custom("SF Compact Rounded", size: 64))
                    .foregroundStyle(.white)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
            }
            .shadow(color: Color.black.opacity(0.6), radius: 10, x: 0, y: 10)
        }
    }
    
    var cityTextField: some View {
        HStack {
            TextField(placeHolder, text: $cityName, onCommit: {
                if cityName != "" {
                    weatherManager.fetchWeather(cityName: cityName)
                    print(cityName)
                    currentCity = cityName
                    DispatchQueue.main.async {
                        cityName = ""
                        placeHolder = "Enter the name of the city"
                    }
                } else {
                    placeHolder = "You Must Enter a City"
                }
            })
            .padding(10)
            .background(Color(UIColor.secondarySystemBackground).opacity(0.7))
            .cornerRadius(10)
            .focused($isFirstResponder)
            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.6),
                    radius: 10, x: 0, y: 10)
            .textInputAutocapitalization(.words)
            
            searchButton
        }
    }
    
    var searchButton: some View {
        Button(action: {
            print(cityName)
            currentCity = cityName
            DispatchQueue.main.async { cityName = "" }
        }) {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.6),
                        radius: 10, x: 0, y: 10)
        }
    }
    
    var temperatureDisplay: some View {
        Text("22°C")  // Puedes vincular esto a una variable si es necesario
            .font(.system(size: 70))
            .fontWeight(.bold)
    }
    
    var cityNameDisplay: some View {
        Text(currentCity)
            .font(.title2)
    }
    
    var imageArea: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)  // Marcos
                .fill(Color(UIColor.systemBackground))  // Fondo dinámico
                .shadow(color: Color.black.opacity(0.6), radius: 10, x: 0, y: 10)
            RoundedRectangle(cornerRadius: 30)  // Borde
                .stroke(lineWidth: 8)
                .foregroundColor(.gray)
        }
       // .padding(.vertical, 30)
    }
    
}

#Preview {
    ContentView()
}
