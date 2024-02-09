//
//  Weather.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 08.02.2024.
//

import Foundation
import Combine

class Weather: ObservableObject {
    
    var current: WeatherData?
    var forecast: WeatherForecast?
    
    init(current: WeatherData? = nil, forecast: WeatherForecast? = nil) {
        self.current = current
        self.forecast = forecast
    }
}
