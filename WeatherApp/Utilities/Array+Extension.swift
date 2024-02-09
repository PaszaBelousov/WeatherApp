//
//  Array+Extension.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import Foundation

extension Array where Element: Equatable {
    
    func unique() -> [Element] {
        self.reduce([]) { result, element in
            result.contains(element) ? result : result + [element]
        }
    }
}

