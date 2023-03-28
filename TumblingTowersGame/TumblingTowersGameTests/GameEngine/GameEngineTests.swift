//
//  GameEngineTests.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class GameEngineTests: XCTestCase {

    var testGameEngine: GameEngine?

    override func setUp() {
        let levelDimensions = CGRect(x: 0, y: 0, width: 500, height: 500)
        testGameEngine = GameEngine(levelDimensions: levelDimensions)
    }

    func testConstruct() {
        let levelDimensions = CGRect(x: 0, y: 0, width: 100, height: 100)
        let gameEngine = GameEngine(levelDimensions: levelDimensions)

        XCTAssertEqual(gameEngine.levelDimensions, levelDimensions)
        XCTAssertTrue(gameEngine.fiziksEngine.fiziksContactDelegate === gameEngine)
    }

    func testInsertNewBlock() throws {
        let originalNumOfGameObjects = try XCTUnwrap(testGameEngine?.gameObjects.count)

        testGameEngine?.insertNewBlock()

        XCTAssertEqual(testGameEngine?.gameObjects.count, originalNumOfGameObjects + 1)
    }

    func testMoveSideways_right() throws {
        let movementVector = CGVector(dx: 10, dy: 10)

        let block = try XCTUnwrap(testGameEngine?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = CGPoint(x: blockOriginalPosition.x + 10, y: blockOriginalPosition.y)

        testGameEngine?.moveSideways(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testMoveSideways_left() throws {
        let movementVector = CGVector(dx: -10, dy: 10)

        let block = try XCTUnwrap(testGameEngine?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = CGPoint(x: blockOriginalPosition.x - 10, y: blockOriginalPosition.y)

        testGameEngine?.moveSideways(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testMoveDown_downwardVector() throws {
        let movementVector = CGVector(dx: -10, dy: -10)

        let block = try XCTUnwrap(testGameEngine?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = CGPoint(x: blockOriginalPosition.x, y: blockOriginalPosition.y - 10)

        testGameEngine?.moveDown(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testMoveDown_upwardVector_doesNotMove() throws {
        let movementVector = CGVector(dx: -10, dy: 10)

        let block = try XCTUnwrap(testGameEngine?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = blockOriginalPosition

        testGameEngine?.moveDown(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testRotateClockwise() throws {
        let block = try XCTUnwrap(testGameEngine?.insertNewBlock())
        let blockOriginalZRotation = block.zRotation
        let expectedBlockFinalZRotation = blockOriginalZRotation - (Double.pi / 2)

        testGameEngine?.rotateClockwise()

        XCTAssertEqual(block.zRotation, expectedBlockFinalZRotation)
    }

    func testRotateCounterClockwise() throws {
        let block = try XCTUnwrap(testGameEngine?.insertNewBlock())
        let blockOriginalZRotation = block.zRotation
        let expectedBlockFinalZRotation = blockOriginalZRotation + (Double.pi / 2)

        testGameEngine?.rotateCounterClockwise()

        XCTAssertEqual(block.zRotation, expectedBlockFinalZRotation)
    }
}
