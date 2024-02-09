//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import Foundation

struct WeatherForecast: Codable {
    
    var list: [WeatherData]
    
    /// Get desired number of forecast days. API limits to 5 days including current.
    func limited(by days: Int = 3) -> [WeatherData] {
        var forecast = [WeatherData]()
        
        list.forEach { weather in
            if !forecast.map({ $0.date() }).contains(weather.date()) {
                var weather = weather
                
                let weatherForDay = list.filter { $0.date() == weather.date() }
                let minTemp = weatherForDay.map { $0.temperature.min }.min()
                let maxTemp = weatherForDay.map { $0.temperature.max }.max()
                
                weather.temperature.min = minTemp ?? 0.0
                weather.temperature.max = maxTemp ?? 0.0
                
                forecast.append(weather)
            }
        }
        
        // Days + 1 to not display current day
        return Array(forecast.prefix(days + 1).dropFirst())
    }
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        
        case list
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([WeatherData].self, forKey: .list)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(list, forKey: .list)
    }
}
