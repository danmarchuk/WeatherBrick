//
//  Created by Volodymyr Andriienko on 11/3/21.
//  Copyright © 2021 VAndrJ. All rights reserved.
//

import XCTest

final class WeatherBrickUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.launch()
        
        let locationButton = app.buttons.element(matching: .any, identifier: "LocalizeButtonIdentifier")
        XCTAssertTrue(locationButton.exists)
        locationButton.tap()
        
        let searchButton = app.buttons.element(matching: .any, identifier: "SearchButtonIdentifier")
        XCTAssertTrue(searchButton.exists)
        searchButton.tap()
        
        let allertTextField = app.textFields.element(matching: .any, identifier: "AlertTextfieldIdentifier")
        XCTAssertTrue(allertTextField.exists)
        allertTextField.tap()
        allertTextField.typeText("Warsaw")
        
        let alert = XCUIApplication().alerts["AllertIdentifier"].firstMatch
        XCTAssertTrue(alert.exists)
        
        let OKButton = alert.buttons["OK"]
        XCTAssertTrue(OKButton.exists)
        OKButton.tap()
        
        let cityLabel = app.staticTexts.element(matching: .any, identifier: "CityLabelIdentifier")
        XCTAssertTrue(cityLabel.exists)
        let expectedValue = "Warsaw"
        
        // Wait for the label's value to change to the expected value
        while !cityLabel.label.contains(expectedValue) {
            // Wait for a short period of time before checking the label's value again
            sleep(1)
        }
        XCTAssertTrue(cityLabel.label.contains(expectedValue))
        
        let infoButton = app.buttons.element(matching: .any, identifier: "InfoButtonIdentifier")
        XCTAssertTrue(infoButton.exists)
        infoButton.tap()
        
        let hideButton = app.buttons.element(matching: .any, identifier: "HideButtonIdentifier")
        XCTAssertTrue(hideButton.exists)
        hideButton.tap()
    }
}
