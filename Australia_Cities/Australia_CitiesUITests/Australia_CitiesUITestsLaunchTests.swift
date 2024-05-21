//
//  Australia_CitiesUITestsLaunchTests.swift
//  Australia_CitiesUITests
//
//  Created by Jaya Lakshmi on 21/05/24.
//

import XCTest

final class Australia_CitiesUITestsLaunchTests: XCTestCase {
    
    var app: XCUIApplication!
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testLaunch() throws {
        
        
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testCityListScreen() throws {
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.waitForExistence(timeout: 10))
        
        let loadingIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(loadingIndicator.exists)
        
        let loadedExpectation = expectation(for: NSPredicate(format: "exists == 0"), evaluatedWith: loadingIndicator, handler: nil)
        XCTWaiter().wait(for: [loadedExpectation], timeout: 10)
        
        XCTAssertFalse(loadingIndicator.exists)
        
        let cells = tableView.cells
        XCTAssertTrue(cells.count > 0)
        
        let firstCell = cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
    }
}
