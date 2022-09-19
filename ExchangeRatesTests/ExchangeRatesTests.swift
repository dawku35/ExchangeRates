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
        
    }

    override func tearDownWithError() throws {
        
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
    
    func test_UnitTestingConvertComponentsfuncfetchConvert_decodeddata_shouldreturngoodconvertResponse() async{
        let convertComponentsMock = ConvertComponentsMock(shouldFail: false)
        let convertViewModel = await ConvertViewModel(to: "PLN", convertComponents: convertComponentsMock)
        
        do{
            await convertViewModel.getConvert()
        }
        
        XCTAssertFalse(convertComponentsMock.shouldFail!)
    }
    
    func test_UnitTestingConvertComponentsfuncfetchConvert_decodeddata_shouldReturnError() async{
        let convertComponentsMock = ConvertComponentsMock(shouldFail: true)
        let convertViewModel = await ConvertViewModel(to: "PLN", convertComponents: convertComponentsMock)
        
        do{
            await convertViewModel.getConvert()
        }
        
        XCTAssertFalse(convertComponentsMock.shouldFail!)
    }
    
    func test_UnitTestingConvertAlertViewModel_item_shouldreturngoodvalues(){
        let convertAlertViewModel = ConvertAlertViewModel(item: ConvertResponse.init())
        let item = ConvertResponse.init()
        
        XCTAssertEqual(item.query.from, convertAlertViewModel.from)
        XCTAssertEqual(item.query.to, convertAlertViewModel.to)
        XCTAssertEqual(item.date, convertAlertViewModel.date)
        XCTAssertEqual(String(format: "%.3f", item.info.rate), convertAlertViewModel.rate)
    }
    
    func testPerformanceExample() throws {
        
        self.measure {
            
        }
    }
    
}
