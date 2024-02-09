//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import Foundation

struct WeatherData: Equatable, Codable {
    
    var condition: [WeatherCondition]
    var temperature: WeatherTemperature
    var timestamp: Double
    
    func date() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        lhs.timestamp == rhs.timestamp
    }
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {
        
        case condition = "weather"
        case temperature = "main"
        case timestamp = "dt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        condition = try container.decode([WeatherCondition].self, forKey: .condition)
        temperature = try container.decode(WeatherTemperature.self, forKey: .temperature)
        timestamp = try container.decode(Double.self, forKey: .timestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(condition, forKey: .condition)
        try container.encode(temperature, forKey: .temperature)
        try container.encode(timestamp, forKey: .timestamp)
    }
}
