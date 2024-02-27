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
    

}
