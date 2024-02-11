//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @EnvironmentObject private var location: Location
    
    var body: some View {
        VStack {
            Text(location.title ?? "")
                .font(.title)
                .padding(.top, 40)
            
            Text("\(location.weather.current?.temperature.formatted(.now) ?? "--")")
                .font(.largeTitle)
            
            Text(location.weather.current?.condition.first?.description.capitalized ?? "")
                .font(.callout)
        }
        .foregroundStyle(Color.white)
    }
}
