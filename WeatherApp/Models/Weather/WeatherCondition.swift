//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import Foundation

struct WeatherCondition: Codable {
    
    var description: String
    
    init(description: String) {
        self.description = description
    }
}
