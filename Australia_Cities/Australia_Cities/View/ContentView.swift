//
//  ContentView.swift
//  Australia_Cities
//
//  Created by Jaya Lakshmi on 21/05/24.
//
import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel = CityListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .foregroundColor(Color.primary)
                        .accessibility(hidden: true)
                } else {
                    List {
                        ForEach(viewModel.citiesByState.sorted(by: { $0.key < $1.key }), id: \.key) { state, cities in
                            DisclosureGroup(
                                isExpanded: Binding(
                                    get: {
                                        if let expandedState = self.viewModel.expandedState {
                                            return expandedState == state
                                        } else {
                                            return false
                                        }
                                    },
                                    set: { newValue in
                                        if newValue {
                                            self.viewModel.expandedState = state
                                        } else {
                                            self.viewModel.expandedState = nil
                                        }
                                    }
                                ),
                                content: {
                                    ForEach(cities, id: \.city) { city in
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(city.city)
                                                .font(.headline)
                                                .foregroundColor(Color.primary)
                                                .accessibility(label: Text("\(city.city), \(state)"))
                                            Text("Latitude: \(city.lat)")
                                                .foregroundColor(Color.secondary)
                                                .accessibility(label: Text("Latitude: \(city.lat)"))
                                            Text("Longitude: \(city.lng)")
                                                .foregroundColor(Color.secondary)
                                                .accessibility(label: Text("Longitude: \(city.lng)"))
                                            Text("Population: \(city.population)")
                                                .foregroundColor(Color.secondary)
                                                .accessibility(label: Text("Population: \(city.population)"))
                                        }
                                        .padding(.vertical, 5)
                                    }
                                },
                                label: {
                                    Text(state)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.primary)
                                        .accessibility(label: Text("\(state), \(cities.count) cities"))
                                }
                            )
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationBarTitle("Australia Cities")
        }
        .onAppear {
            viewModel.fetchData()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


