//
//  HomeView.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 08.02.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var location = Location()

    @State var editTapped = false
    
    var body: some View {
        VStack {
            EditButton(editTapped: $editTapped)
            CurrentWeatherView()
                .environmentObject(location)
            
            Spacer()
            
            ForecastView()
                .environmentObject(location)
            
            Spacer()
            Spacer()
            Spacer()
        }
        .task {
            do {
                #if targetEnvironment(simulator)
                try await location.fetchWeather(for: .london)
                #else
                await location.current.checkAuthorization()
                
                let locationData = try await location.current.value
                try await location.fetchWeather(for: locationData)
                #endif
            } catch {
                print(error.localizedDescription)
            }
        }
        .sheet(isPresented: $editTapped) {
            EditView()
                .environmentObject(location)
        }
        .background {
            LinearGradient(
                colors: [.gray, .blue],
                startPoint: UnitPoint.topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }
    
    struct EditButton: View {
        
        @Binding var editTapped: Bool
        
        var body: some View {
            HStack {
                Spacer()
                
                Button(action: {
                    editTapped = true
                }, label: {
                    Text("Edit")
                        .foregroundStyle(Color.white)
                })
                .padding(.trailing, 20)
            }
        }
    }
}

#Preview {
    HomeView()
}
