//
//  APIProvider.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 08.02.2024.
//

import Foundation
import Combine

enum APIProviderErrors: Error {
    
    case badURL
    case badRequest
    case unauthorized
    case http(httpResponse: HTTPURLResponse, data: Data)
}

class APIProvider {
    
    static let shared: APIProvider = .init()
    
    func getData(from endpoint: EndpointProtocol) async throws -> (Data, URLResponse) {
        
        guard let url = URLComponents(string: endpoint.absoluteURL)?.url else {
            throw APIProviderErrors.badURL
        }
        
        return try await URLSession.shared.data(from: url)
    }
    
    
    func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        let statusCode = URLError.Code(rawValue: httpResponse.statusCode)
        if statusCode.rawValue > 300 {
            throw URLError(statusCode)
        } else {
            return response.data
        }
    }
}
