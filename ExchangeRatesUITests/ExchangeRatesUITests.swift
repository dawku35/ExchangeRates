//
//  ExchangeRatesUITests.swift
//  ExchangeRatesUITests
//
//  Created by Dawid Kunz on 06/09/2022.
//

import XCTest

class ExchangeRatesUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.activate()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_UITestingConvertView_menuButton_shouldShowAlert() throws {
        let currencies = ["PLN", "GBP", "USD", "JPY", "AED"]
        let chooseButton = app.buttons["Choose"]
        XCTAssertTrue(chooseButton.waitForExistence(timeout: 4.0))
        chooseButton.tap()
        for currency in currencies {
            let currencyButton = app.buttons[currency]
            XCTAssertTrue(currencyButton.exists)
            currencyButton.tap()
            
            let fromText = app.staticTexts["from EUR"]
            XCTAssertTrue(fromText.waitForExistence(timeout: 4.0))
            let toText = app.staticTexts["To \(currency)"]
            XCTAssertTrue(toText.waitForExistence(timeout: 4.0))
            
            XCTAssertTrue(currencyButton.exists)
            currencyButton.tap()
        }
    }
    
    func test_UITestingConvertView_menuButton_shouldShowErrorConnection() throws {
        
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.scrollViews["ControlCenterLayoutView"].otherElements.scrollViews.otherElements.switches["wifi-button"]/*[[".otherElements[\"ControlCenterView\"].scrollViews.otherElements.scrollViews[\"ControlCenterLayoutView\"].otherElements.scrollViews.otherElements",".switches[\"Wi-Fi, Willa_na_Jeżowskiej\"]",".switches[\"wifi-button\"]",".scrollViews.otherElements.scrollViews[\"ControlCenterLayoutView\"].otherElements.scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.otherElements["ControlCenterView"].children(matching: .scrollView).element.tap()
        app.buttons["Choose"].tap()
        app.buttons["PLN"].tap()
        
        for _ in 1..<5 {
            let badConnectionButton = app.buttons["Retry"]
            XCTAssertTrue(badConnectionButton.waitForExistence(timeout: 4.0))
            badConnectionButton.tap()
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
