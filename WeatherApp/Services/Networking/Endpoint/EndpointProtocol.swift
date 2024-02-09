//
//  EndpointProtocol.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 08.02.2024.
//

import Foundation

protocol EndpointProtocol {

    var baseURL: String { get }
    var absoluteURL: String { get }
}
