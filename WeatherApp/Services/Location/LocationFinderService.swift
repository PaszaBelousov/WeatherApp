//
//  LocationFinderService.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import Combine
import MapKit

class LocationFinderService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var query = ""
    @Published var completions = [MKLocalSearchCompletion]()
    
    private let completer = MKLocalSearchCompleter()
    private var cancellable: AnyCancellable?
    
    override init() {
        super.init()
        
        setupObservers()
        completer.delegate = self
    }
    
    private func setupObservers() {
        cancellable = $query.assign(to: \.queryFragment, on: completer)
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completions = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        completions = []
    }
}
