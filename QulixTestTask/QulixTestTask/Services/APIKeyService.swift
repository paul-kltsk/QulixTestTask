//
//  APIKeyService.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 26/02/2024.
//

import Foundation

struct APIKeyService {
    
    // MARK: - Get API key
    static func getAPIKey() -> String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let apiKey = plist["OpenWeatherMapAPIKey"] as? String else {
            fatalError("Unable to find OpenWeatherMapAPIKey in Secrets.plist")
        }
        return apiKey
    }
    
}
