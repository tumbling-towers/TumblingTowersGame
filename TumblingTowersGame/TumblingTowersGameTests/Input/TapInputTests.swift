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

        tapInput.start(levelWidth: 1_000, levelHeight: 1_000)

        let currInput = tapInput.getInput()

        XCTAssertEqual(currInput, .NONE)
    }

    func testLeftMove() {
        let tapInput = TapInput()

        tapInput.start(levelWidth: 1_000, levelHeight: 1_000)
        tapInput.tapEvent(at: CGPoint(x: 20, y: 500))

        let currInput = tapInput.getInput()

        XCTAssertEqual(currInput, .LEFT)
    }

    func testRightMove() {
        let tapInput = TapInput()

        tapInput.start(levelWidth: 1_000, levelHeight: 1_000)
        tapInput.tapEvent(at: CGPoint(x: 720, y: 500))

        let currInput = tapInput.getInput()

        XCTAssertEqual(currInput, .RIGHT)
    }

}
