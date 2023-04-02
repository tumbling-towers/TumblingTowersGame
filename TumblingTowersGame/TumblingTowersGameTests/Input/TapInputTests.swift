//
//  TapInputTests.swift
//  TumblingTowersGameTests
//
//  Created by Elvis on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class TapInputTests: XCTestCase {

    func testConstruct() {
        let tapInput = TapInput()

        let currInput = tapInput.getInput()

        XCTAssertEqual(currInput.inputType, .NONE)
        XCTAssertEqual(currInput.vector, .zero)
    }

    func testLeftMove() {
        let tapInput = TapInput()

        tapInput.dragEvent(offset: CGSize(width: -100, height: 0))
        var currInput = tapInput.getInput()
        XCTAssertEqual(currInput.inputType, .LEFT)

        tapInput.dragEvent(offset: CGSize(width: -100, height: 51))
        currInput = tapInput.getInput()
        XCTAssertEqual(currInput.inputType, .NONE)
    }

    func testRightMove() {
        let tapInput = TapInput()

        tapInput.dragEvent(offset: CGSize(width: 100, height: 0))
        var currInput = tapInput.getInput()
        XCTAssertEqual(currInput.inputType, .RIGHT)

        tapInput.dragEvent(offset: CGSize(width: 100, height: 51))
        currInput = tapInput.getInput()
        XCTAssertEqual(currInput.inputType, .NONE)
    }

}
