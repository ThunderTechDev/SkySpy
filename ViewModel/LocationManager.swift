//
//  LocationManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 19/1/24.
//

import CoreLocation
import SwiftUI

@Observable class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationData: LocationData?
    var cityName: String = "Inicializacion inicial"
    
    private var locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationData = LocationData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        lookupCityName(from: location)
    }

    private func lookupCityName(from location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self, let placemark = placemarks?.first, error == nil else { return }
            self.cityName = placemark.locality ?? "Ubicación desconocida"

        }
    }
 
}






