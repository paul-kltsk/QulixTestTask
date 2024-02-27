//
//  APIKeyServiceTest.swift
//  QulixTestTaskTests
//
//  Created by Pavel Kylitsky on 27/02/2024.
//

import XCTest
@testable import QulixTestTask

final class APIKeyServiceTest: XCTestCase {
    
    // MARK: - Case 1: Sercets.plist found
    func testSercetsPlistFile() {
        XCTAssertNotNil(Bundle.main.path(forResource: "Secrets", ofType: "plist"))
    }
    
    // MARK: - Case 2: Test key field OpenWeatherMapAPIKey in Secrets.plist
    func testAPIKeyFieldExists() {
           // path to Secrets.plist
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            XCTFail("Secrets.plist file not found")
            return
        }
           
           // get Secrets.plist dictionary
        guard let plist = NSDictionary(contentsOfFile: path) else {
            XCTFail("Unable to read Secrets.plist")
            return
        }
           // cheking OpenWeatherMapAPIKey filed in dictionary
        XCTAssertNotNil(plist["OpenWeatherMapAPIKey"], "Field OpenWeatherMapAPIKey not found in Secrets.plist")
    }
    
    // MARK: - Case 3: Checking field value for key OpenWeatherMapAPIKey in Secrets.plist
    func testAPIKeyFieldValueNotNil() {
            
            // path to Secrets.plist
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            XCTFail("Secrets.plist file not found")
            return
        }
            
            // get Secrets.plist dictionary
        guard let plist = NSDictionary(contentsOfFile: path) else {
            XCTFail("Unable to read Secrets.plist")
            return
        }
            
            // Get value for key OpenWeatherMapAPIKey from dict
        guard let apiKey = plist["OpenWeatherMapAPIKey"] as? String else {
            XCTFail("Field OpenWeatherMapAPIKey is nil in Secrets.plist")
            return
        }
            
            // Checking OpenWeatherMapAPIKey value not nil
        XCTAssertNotNil(apiKey, "Field OpenWeatherMapAPIKey is nil in Secrets.plist")
    }

}
