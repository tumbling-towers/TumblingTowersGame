//
//  ShapeRandomizerTests.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 17/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class ShapeRandomizerTests: XCTestCase {

    func testGetShape() {
        let shapeRandomizer = ShapeRandomizer(possibleShapes: TetrisType.allCases, seed: 10)

        // Repeat 10 times, taking out 7 shapes each time.
        // The shapes should only repeat after getting 7 unique shapes.
        for _ in 1...10 {
            var expectedShapes = Set(TetrisType.allCases)
            for _ in 0..<TetrisType.allCases.count {
                let randomShape = shapeRandomizer.createRandomShape()
                XCTAssertNotNil(expectedShapes.remove(randomShape.type))
            }
            XCTAssertTrue(expectedShapes.isEmpty)
        }
    }
}
