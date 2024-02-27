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
    
    // MARK: - Case 2: Test field OpenWeatherMapAPIKey in Secrets.plist
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

}
