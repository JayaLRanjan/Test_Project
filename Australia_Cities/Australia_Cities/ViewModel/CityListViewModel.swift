//
//  CityListViewModel.swift
//  Australia_Cities
//
//  Created by Jaya Lakshmi on 21/05/24.
//

import Foundation

class CityListViewModel: ObservableObject {
    @Published var citiesByState: [String: [WelcomeElement]] = [:]
    @Published var isLoading: Bool = false
    @Published var isStateExpanded: [String: Bool] = [:]
    @Published var expandedState: String? = nil

    //MARK: Fetchind data from backend if cached data not available.
    func fetchData() {
        isLoading = true
        BackendService.fetchCities { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self.citiesByState = Dictionary(grouping: cities, by: { $0.adminName.rawValue })
                    
                    self.isStateExpanded = Dictionary(uniqueKeysWithValues: self.citiesByState.keys.map { ($0, false) })
                    //Cacheing the fetched data.
                    self.cacheFetchedData(cities)
                case .failure(let error):
                    print("Failed to fetch data: \(error)")
                    //If fetching from backend fails, load data from local au_cities JSON file.
                    if let cachedCities = self.loadCachedData() {
                        self.citiesByState = cachedCities
                        self.isStateExpanded = Dictionary(uniqueKeysWithValues: self.citiesByState.keys.map { ($0, false) })
                    }
                }
                self.isLoading = false
            }
        }
    }
    
    //MARK: Cache the fetched data.
    private func cacheFetchedData(_ cities: [WelcomeElement]) {
        do {
            let data = try JSONEncoder().encode(cities)
            
            UserDefaults.standard.set(data, forKey: "cachedCitiesData")
        } catch {
            print("Error caching data: \(error)")
        }
    }
    
    //MARK: Loading cached data from au_cities.json file
    private func loadCachedData() -> [String: [WelcomeElement]]? {
        
        guard let fileURL = Bundle.main.url(forResource: "au_cities", withExtension: "json") else {
            print("File 'au_cities.json' not found in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let cities = try JSONDecoder().decode([WelcomeElement].self, from: data)
            return Dictionary(grouping: cities, by: { $0.adminName.rawValue })
        } catch {
            print("Error loading data from 'au_cities.json': \(error)")
            return nil
        }
    }
}

