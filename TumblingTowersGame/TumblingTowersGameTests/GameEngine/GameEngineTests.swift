//
//  GameWorldTests.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class GameWorldTests: XCTestCase {

    var testGameWorld: GameWorld?

    override func setUp() {
        let levelDimensions = CGRect(x: 0, y: 0, width: 500, height: 500)
        testGameWorld = GameWorld(levelDimensions: levelDimensions)
    }

    func testConstruct() {
        let levelDimensions = CGRect(x: 0, y: 0, width: 100, height: 100)
        let GameWorld = GameWorld(levelDimensions: levelDimensions)

        XCTAssertEqual(GameWorld.levelDimensions, levelDimensions)
        XCTAssertTrue(GameWorld.fiziksEngine.fiziksContactDelegate === GameWorld)
    }

    func testInsertNewBlock() throws {
        let originalNumOfGameObjects = try XCTUnwrap(testGameWorld?.gameObjects.count)

        testGameWorld?.insertNewBlock()

        XCTAssertEqual(testGameWorld?.gameObjects.count, originalNumOfGameObjects + 1)
    }

    func testMoveSideways_right() throws {
        let movementVector = CGVector(dx: 10, dy: 10)

        let block = try XCTUnwrap(testGameWorld?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = CGPoint(x: blockOriginalPosition.x + 10, y: blockOriginalPosition.y)

        testGameWorld?.moveSideways(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testMoveSideways_left() throws {
        let movementVector = CGVector(dx: -10, dy: 10)

        let block = try XCTUnwrap(testGameWorld?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = CGPoint(x: blockOriginalPosition.x - 10, y: blockOriginalPosition.y)

        testGameWorld?.moveSideways(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testMoveDown_downwardVector() throws {
        let movementVector = CGVector(dx: -10, dy: -10)

        let block = try XCTUnwrap(testGameWorld?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = CGPoint(x: blockOriginalPosition.x, y: blockOriginalPosition.y - 10)

        testGameWorld?.moveDown(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testMoveDown_upwardVector_doesNotMove() throws {
        let movementVector = CGVector(dx: -10, dy: 10)

        let block = try XCTUnwrap(testGameWorld?.insertNewBlock())
        let blockOriginalPosition = block.position
        let expectedBlockFinalPosition = blockOriginalPosition

        testGameWorld?.moveDown(by: movementVector)

        XCTAssertEqual(block.position, expectedBlockFinalPosition)
    }

    func testRotateClockwise() throws {
        let block = try XCTUnwrap(testGameWorld?.insertNewBlock())
        let blockOriginalZRotation = block.zRotation
        let expectedBlockFinalZRotation = blockOriginalZRotation - (Double.pi / 2)

        testGameWorld?.rotateClockwise()

        XCTAssertEqual(block.zRotation, expectedBlockFinalZRotation)
    }

    func testRotateCounterClockwise() throws {
        let block = try XCTUnwrap(testGameWorld?.insertNewBlock())
        let blockOriginalZRotation = block.zRotation
        let expectedBlockFinalZRotation = blockOriginalZRotation + (Double.pi / 2)

        testGameWorld?.rotateCounterClockwise()

        XCTAssertEqual(block.zRotation, expectedBlockFinalZRotation)
    }
}
