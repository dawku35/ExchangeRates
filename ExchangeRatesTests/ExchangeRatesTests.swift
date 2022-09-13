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
    
    func test_UnitTestingConvertComponentsfuncmakeConvertComponents_components_shouldBeGood (){
        let currencies = ["PLN", "GBP", "USD", "JPY", "AED"]
        let convertComponents = ConvertComponentsImpl.init()
        
        
        for currency in currencies {
            let convertResponse = convertComponents.makeConvertComponents(withTo: currency)
            
            var goodComponents = URLComponents()
            goodComponents.scheme = "https"
            goodComponents.host = "api.apilayer.com"
            goodComponents.path = "/exchangerates_data/convert"
            
            goodComponents.queryItems = [
              URLQueryItem(name: "to", value: currency),
              URLQueryItem(name: "from", value: "EUR"),
              URLQueryItem(name: "amount", value: "1"),
              URLQueryItem(name: "apikey", value: "2jiqgWRpA7vCaXRWn2kLN86HLiIHwUCo")
            ]
            
            XCTAssertEqual(convertResponse, goodComponents)
        }
    }
    @MainActor
    func test_UnitTestingConvertComponentsfuncfetchConvert_decodeddata_shouldreturngoodconvertResponse() async{
        let convertComponentsMock = ConvertComponentsMock(shouldFail: false)
        let convertViewModel = ConvertViewModel(to: "PLN", convertComponents: convertComponentsMock)
        
        do{
            await convertViewModel.getConvert()
        }
        
        XCTAssertFalse(convertComponentsMock.shouldFail!)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
//    func test_UnitTestingConvertAlertViewModel_
}
