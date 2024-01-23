//
//  LocationManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 19/1/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var cityName: String = "Cargando..."

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Solicita permiso al usuario
        locationManager.startUpdatingLocation() // Comienza a obtener la ubicación
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            updateCityName(from: location)
        }
    }

    private func updateCityName(from location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error en Geocoding: \(error.localizedDescription)")
                return
            }

            if let placemark = placemarks?.first, let city = placemark.locality {
                DispatchQueue.main.async {
                    self.cityName = city
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener la ubicación: \(error.localizedDescription)")
    }
}





