//
//  NetworkService.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 26/02/2024.
//

import Foundation

class NetworkService {
    
    static var shared = NetworkService()

    // MARK: - Properties
    private let urlFirst = "https://api.openweathermap.org/data/2.5/forecast?units=metric&"
    private let token = APIKeyManager.getAPIKey()
    
    // Minsk coordinates
    private let latitude = "53.9"
    private let longitude = "27.6"
    
    // MARK: - Get weather data from API
    func fetchData(completion: @escaping (Result<Data,APIError>) -> Void) {
        
        let fullUrl = urlFirst + "lat=\(latitude)&lon=\(longitude)&appid=\(token)"
        
        guard let url = URL(string: fullUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                // Check for errors
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }

                // Check for a valid HTTP response
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.invalidResponse))
                    return
                }

                // Check if data is available
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }

                // If all checks pass, call the completion handler with the data
                completion(.success(data))

            }.resume()
    }
    
}

// MARK: - Types of error
extension NetworkService {
    
    enum APIError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidResponse
        case invalidData
    }
    
}
