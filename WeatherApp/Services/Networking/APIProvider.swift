//
//  APIProvider.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 08.02.2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    
    case badURL
    case badRequest
    case unauthorized
    case http(httpResponse: HTTPURLResponse, data: Data)
}

class APIProvider {
    
    static let shared: APIProvider = .init()
    
    func getResponse(from endpoint: EndpointProtocol) async throws -> (Data, URLResponse) {
        guard let url = URLComponents(string: endpoint.absoluteURL)?.url else {
            throw NetworkError.badURL
        }
        
        return try await URLSession.shared.data(from: url)
    }
    
    func getData(for response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.http(httpResponse: httpResponse, data: response.data)
        }
    }
}
