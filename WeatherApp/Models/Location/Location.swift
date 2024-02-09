//
//  Item.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 08.02.2024.
//

import Combine
import CoreLocation
import MapKit

@MainActor
class Location: NSObject, ObservableObject {
    
    /// Current location title
    @Published var title: String?
    /// Current location weather
    @Published var weather: Weather?
    
    ///Provides current user location
    let current = CurrentLocationService()
    ///Provides new locations
    @Published var finder = LocationFinderService()
    
    /// Returns weather for desired location
    func fetchWeather(for location: CLLocation) async throws {
        let currentWeather = try await getCurrentWeather(for: location)
        let forecast = try await getForecast(for: location)
        try await setTitle(for: location)
        
        weather = Weather(current: currentWeather, forecast: forecast)
    }
    
    /// Change location from search
    func changeLocation(_ location: MKLocalSearchCompletion) async throws {
        let request = MKLocalSearch.Request(completion: location)
        let search = MKLocalSearch(request: request)
        
        let response = try await search.start()
        let placemark = response.mapItems.map { $0.placemark }.first
        guard let placemarkCoordinate = placemark?.coordinate else { return }
        
        let location = CLLocation(latitude: placemarkCoordinate.latitude, longitude: placemarkCoordinate.longitude)
        try await fetchWeather(for: location)
    }
    
    private func getCurrentWeather(for location: CLLocation) async throws -> WeatherData {
        let endpoint = WeatherEndpoint.getCurrent(latitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude)
        let reesponse = try await APIProvider.shared.getData(from: endpoint)
        let data = try APIProvider.shared.mapResponse(response: reesponse)
        return try JSONDecoder().decode(WeatherData.self, from: data)
    }
    
    private func getForecast(for location: CLLocation) async throws -> WeatherForecast {
        let endpoint = WeatherEndpoint.getForecast(latitude: location.coordinate.latitude,
                                                   longitude: location.coordinate.longitude)
        let reesponse = try await APIProvider.shared.getData(from: endpoint)
        let data = try APIProvider.shared.mapResponse(response: reesponse)
        return try JSONDecoder().decode(WeatherForecast.self, from: data)
    }
    
    private func setTitle(for location: CLLocation) async throws {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        guard let placemark = placemarks.first, let cityName = placemark.locality else {
            return
        }
        
        title = cityName
    }
}

extension CLLocation {
    
    static let london = CLLocation(latitude: 51.507222, longitude: -0.1275)
}
