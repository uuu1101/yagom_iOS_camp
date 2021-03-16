//
//  WeatherForecast - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import CoreLocation

final class ViewController: UIViewController {
    
    private var currentWeather: CurrentWeather?
    private var forecastFiveDays: ForecastFiveDays?
    private var locationManager = CLLocationManager()
    private var currentAddress: String = String.empty
    private var latitude: Double = .zero
    private var longitude: Double = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPLocationManager()
    }
    
    private func setUpAPI(latitude: Double, longitude: Double) {
        decodeCurrentWeaterFromAPI(latitude: latitude, longitude: longitude)
        decodeForecastFiveDaysFromAPI(latitude: latitude, longitude: longitude)
    }
    
    private func decodeCurrentWeaterFromAPI(latitude: Double, longitude: Double) {
        guard let url:URL = URLManager.common.makeURL(mode: .currentWeather, latitude: latitude, lontitude: longitude) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data,_,error  in
            guard let data = data else {
                return
            }
            do {
                self.currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    private func decodeForecastFiveDaysFromAPI(latitude: Double, longitude: Double) {
        guard let url:URL = URLManager.common.makeURL(mode: .forecastFiveDays, latitude: latitude, lontitude: longitude) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data,_,error  in
            guard let data = data else {
                return
            }
            do {
                self.forecastFiveDays = try JSONDecoder().decode(ForecastFiveDays.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    @IBAction func printCurrentWeather() {
        dump (currentWeather)
    }
    
    @IBAction func printForecastFiveDays() {
        dump(forecastFiveDays)
    }
    
    @IBAction func printCurrentAddress() {
        print(currentAddress)
    }
    
    func convertToAddress(latitude: Double, longitude: Double) {
        let geoCoder: CLGeocoder = CLGeocoder()
        let coordinate: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        let local: Locale = Locale(identifier: String.localIdentufier)
        geoCoder.reverseGeocodeLocation(coordinate, preferredLocale: local) { place, _ in
            guard let address: [CLPlacemark] = place, let state = address.last?.administrativeArea, let city = address.first?.locality, let township = address.first?.subLocality else {
                return
            }
            self.currentAddress = "\(state) \(city) \(township)"
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func setUPLocationManager () {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        setUpAPI(latitude: latitude, longitude: longitude)
        convertToAddress(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
