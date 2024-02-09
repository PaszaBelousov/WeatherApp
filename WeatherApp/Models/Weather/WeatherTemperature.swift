//
//  WeatherTemperature.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import Foundation

struct WeatherTemperature: Codable {
    
    var now: Double
    var min: Double
    var max: Double
    
    func formatted(_ temperatureKey: CodingKeys,
                   from inputTempType: UnitTemperature = .kelvin,
                   to outputTempType: UnitTemperature = .celsius) -> String {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitOptions = .providedUnit
        
        var input: Measurement = Measurement(value: self.now, unit: inputTempType)
        switch temperatureKey {
        case .now:
            input = Measurement(value: self.now, unit: inputTempType)
        case .min:
            input = Measurement(value: self.min, unit: inputTempType)
        case .max:
            input = Measurement(value: self.max, unit: inputTempType)
        }
         
        let output = input.converted(to: outputTempType)
        return formatter.string(from: output)
    }
    
    // MARK: Codable
    
    enum CodingKeys: String, CodingKey {

        case now = "temp"
        case min = "temp_min"
        case max = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        now = try container.decode(Double.self, forKey: .now)
        min = try container.decode(Double.self, forKey: .min)
        max = try container.decode(Double.self, forKey: .max)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(now, forKey: .now)
        try container.encode(min, forKey: .min)
        try container.encode(max, forKey: .max)
    }
}
