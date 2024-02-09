//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 08.02.2024.
//

import Foundation

fileprivate let apiKey = "Your API key"

enum WeatherEndpoint: EndpointProtocol {
    
    case getCurrent(latitude: Double, longitude: Double)
    case getForecast(latitude: Double, longitude: Double)
    
    var baseURL: String {
        "https://api.openweathermap.org/data/2.5"
    }
    
    var absoluteURL: String {
        switch self {
        case let .getCurrent(latitude, longitude):
            return baseURL + "/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        case let .getForecast(latitude, longitude):
            return baseURL + "/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        }
    }
}
