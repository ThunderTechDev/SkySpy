//
//  LocationManager.swift
//  SkySpy
//
//  Created by Sergio Gonzalez Cristobal on 19/1/24.
//

import Foundation
import CoreLocation

@Observable class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var cityName: String = "Cargando..."

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            updateCityName(from: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener la ubicación: \(error.localizedDescription)")
    }
    
    func updateCityName(from location: CLLocation) {
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

   
}





