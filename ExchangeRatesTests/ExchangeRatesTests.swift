//
//  ExchangeRatesTests.swift
//  ExchangeRatesTests
//
//  Created by Dawid Kunz on 06/09/2022.
//

import XCTest
@testable import ExchangeRates

class ExchangeRatesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UnitTestingConvertFetcherfuncmakeConvertComponents_components_shouldBeGood (){
        let currencies = ["PLN", "GBP", "USD", "JPY", "AED"]
        let convertFetcher = ConvertFetcher.init()
        
        
        for currency in currencies {
            let convertResponse = convertFetcher.ConvertFromEurTo(forTo: currency)
            
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
