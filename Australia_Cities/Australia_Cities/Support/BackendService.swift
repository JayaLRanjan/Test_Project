//
//  BackendService.swift
//  Australia_Cities
//
//  Created by Jaya Lakshmi on 21/05/24.
//

import Foundation

class BackendService {
    //MARK: Fetchind data from backend.
    static func fetchCities(completion: @escaping (Result<[WelcomeElement], Error>) -> Void) {
        let urlString = "https://dummy-api.com/cities"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let cities = try JSONDecoder().decode([WelcomeElement].self, from: data)
                completion(.success(cities))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

