//
//  EditView.swift
//  WeatherApp
//
//  Created by Pavel Belousov on 09.02.2024.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var location: Location

    var body: some View {
        NavigationStack {
            List {
                ForEach(location.finder.completions.unique(), id: \.title) { completion in
                    Button {
                        Task {
                            try? await location.changeLocation(completion)
                            dismiss()
                        }
                    } label: {
                        Text(completion.title)
                    }
                }
            }
            .navigationTitle("Edit")
            .overlay {
                if location.finder.completions.isEmpty {
                    ContentUnavailableView.search
                }
            }
        }
        .searchable(text: $location.finder.query)
    }
}
