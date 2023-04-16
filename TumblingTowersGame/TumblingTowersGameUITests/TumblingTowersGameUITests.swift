//
//  TumblingTowersGameUITests.swift
//  TumblingTowersGameUITests
//
//  Created by Taufiq Abdul Rahman on 16/4/23.
//

import XCTest

final class TumblingTowersGameUITests: XCTestCase {
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric(waitUntilResponsive: true)]) {
                XCUIApplication().launch()
            }
        }
    }
}
