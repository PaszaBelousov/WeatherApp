//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import SwiftUI

struct ForecastView: View {
    
    @EnvironmentObject private var location: Location
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(location.weather?.forecast?.limited() ?? [], id: \.timestamp) { weather in
                HStack {
                    VStack(alignment: .leading) {
                        Text(weather.date())
                        Text(weather.condition.first?.description.capitalized ?? "")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Min: \(weather.temperature.formatted(.min))°")
                        Text("Max: \(weather.temperature.formatted(.max))°")
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .foregroundStyle(Color.white)
    }
}
