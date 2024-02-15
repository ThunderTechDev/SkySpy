//
//  ContentView.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 9/10/23.
//



import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @State private var weatherManager = WeatherManager()
    @State private var cityName: String = ""
    @State private var currentCity: String = "City"
    @State private var placeHolder = "Enter the name of the city"
    @State private var locationManager = LocationManager()
    @FocusState private var isFirstResponder: Bool
    
    
    
    var body: some View {
        ZStack {
            backgroundImage
            mainContent
        }
        .onChange(of: locationManager.cityName, {
            cityName = locationManager.cityName
            searchCity()
        })
        .onTapGesture {
            isFirstResponder = false
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
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
        Image(weatherManager.isDaytime == false ? "darkBackground" : "lightBackground")
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
            localPlaceButton
            TextField(placeHolder, text: $cityName, onCommit: {
                searchCity()
            })
            .autocorrectionDisabled()
            .padding(10)
            .background(Color(UIColor.secondarySystemBackground).opacity(0.7))
            .cornerRadius(10)
            .focused($isFirstResponder)
            .shadow(color: weatherManager.isDaytime == false ? Color.white.opacity(0.5) : Color.black.opacity(0.5),
                    radius: 15)
            .textInputAutocapitalization(.words)
            
            searchButton
        }
    }
    
    var searchButton: some View {
        Button(action: {
            searchCity()
        }) {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(weatherManager.isDaytime  ? .black : .white)
                .shadow(color: weatherManager.isDaytime == false ? .white : Color.black.opacity(0.5),
                        radius: 6)
        }
    }
    
    var temperatureDisplay: some View {
        Text(String(format: "%.1fº", weatherManager.currentWeather?.temperature ?? 0.0))
            .font(.system(size: 70))
            .fontWeight(.bold)
            .foregroundColor(weatherManager.isDaytime  ? .black : .white)
        
        
    }
    
    var cityNameDisplay: some View {
        Text(currentCity)
            .font(.title2)
            .foregroundColor(weatherManager.isDaytime  ? .black : .white)
            .shadow(color: weatherManager.isDaytime ? .white : .black,
                    radius: 4)
    }
    
    var localPlaceButton: some View {
        Button(action: {
            locationManager.locationManager.startUpdatingLocation()
            cityName = locationManager.cityName
            searchCity()
            
        }) {Image(systemName: "mappin.and.ellipse")
                .font(.title)
                .foregroundColor(weatherManager.isDaytime  ? .black : .white)
                .shadow(color: weatherManager.isDaytime == false ? .white : Color.black.opacity(0.5),
                        radius: 6)
        }
        
    }
    
    var imageArea: some View {
        GeometryReader { geometry in
            ZStack {
                if weatherManager.cityError {
                    
                    Image("errorImage.png")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 8)
                        .foregroundColor(.gray)
                    
                } else if let imageName = weatherManager.currentWeather?.conditionName {
                    Image(weatherManager.isDaytime ? "\(imageName).png" : "\(imageName)_night.png")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(lineWidth: 8)
                        .foregroundColor(.gray)
                    
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }

    private func searchCity() {
        Task {
            let success = await weatherManager.fetchWeather(cityName: cityName)
            DispatchQueue.main.async {
                if success {
                    weatherManager.cityError = false
                    currentCity = cityName
                } else {
                    currentCity = "No se encuentra ciudad"
                }
                cityName = ""
                placeHolder = "Enter the name of the city"
            }
        }
        
    }
    
}



#Preview {
    ContentView()
}
