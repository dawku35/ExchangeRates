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
        app.launch()
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
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        let coord1 = app.coordinate(withNormalizedOffset: CGVector(dx: 5, dy: 0.01))
        let coord2 = app.coordinate(withNormalizedOffset: CGVector(dx: 5, dy: 0.2))
        coord1.press(forDuration: 0.1, thenDragTo: coord2)

        let wifiButton = springboard.switches["wifi-button"]
        XCTAssertTrue(wifiButton.waitForExistence(timeout: 2))
        wifiButton.tap()
        
        let coordToBack = app.coordinate(withNormalizedOffset: CGVector(dx: 5, dy: -10))
        coordToBack.tap()
        
        let chooseButton = app.buttons["Choose"]
        XCTAssertTrue(chooseButton.waitForExistence(timeout: 4.0))
        chooseButton.tap()
        
        let currencyButton = app.buttons["PLN"]
        XCTAssertTrue(currencyButton.waitForExistence(timeout: 2.0))
        currencyButton.tap()
        
        for _ in 1..<5 {
            let badConnectionButton = app.buttons["Retry"]
            XCTAssertTrue(badConnectionButton.waitForExistence(timeout: 4.0))
            badConnectionButton.tap()
        }
        
        coord1.press(forDuration: 0.1, thenDragTo: coord2)

        XCTAssertTrue(wifiButton.waitForExistence(timeout: 2.0))
        wifiButton.tap()
        
        coordToBack.tap()
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
