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
    var eventManager: EventManager?
    var playerId: UUID?

    override func setUp() {
        super.setUp()
        let levelDimensions = CGRect(x: 0, y: 0, width: 500, height: 500)
        let mockEventManager = MockEventManager()
        eventManager = mockEventManager

        let newPlayerId = UUID()
        playerId = newPlayerId

        let gameWorld = GameWorld(levelDimensions: levelDimensions,
                                  eventManager: mockEventManager,
                                  playerId: newPlayerId)

        testGameWorld = gameWorld
    }

    func testConstruct() {
        let levelDimensions = CGRect(x: 0, y: 0, width: 100, height: 100)

        let mockEventManager = MockEventManager()
        eventManager = mockEventManager

        let newPlayerId = UUID()
        playerId = newPlayerId

        let gameWorld = GameWorld(levelDimensions: levelDimensions,
                                  eventManager: mockEventManager,
                                  playerId: newPlayerId)

        XCTAssertEqual(gameWorld.level.dimensions, levelDimensions)
        XCTAssertTrue(gameWorld.fiziksEngine.fiziksContactDelegate === gameWorld)
        XCTAssertNotNil(gameWorld.powerupManager)
        XCTAssertNil(gameWorld.currentlyMovingBlock)
    }

    func test_moveCMB() throws {
        let movementVector = CGVector(dx: 10, dy: 10)

        let gameWorld = try XCTUnwrap(testGameWorld)

        gameWorld.insertNewBlock()

        let blockOriginalPosition = try XCTUnwrap(gameWorld.currentlyMovingBlock?.position)

        let expectedBlockFinalPosition = CGPoint(x: blockOriginalPosition.x + movementVector.dx,
                                                 y: blockOriginalPosition.y + movementVector.dy)

        gameWorld.moveCMB(by: movementVector)

        XCTAssertEqual(gameWorld.currentlyMovingBlock?.position, expectedBlockFinalPosition)
    }

    func testRotate() throws {
        let gameWorld = try XCTUnwrap(testGameWorld)

        gameWorld.insertNewBlock()

        let blockOriginalZRotation = try XCTUnwrap(gameWorld.currentlyMovingBlock?.rotation)

        let rotationChange = (Double.pi / 2)
        let expectedBlockFinalZRotation = blockOriginalZRotation + (Double.pi / 2)

        gameWorld.rotateCMB(by: Double.pi / 2)

        let updatedRotation = try XCTUnwrap(gameWorld.currentlyMovingBlock?.rotation)
        XCTAssertEqual(updatedRotation, expectedBlockFinalZRotation, accuracy: 1e-4)
    }

    func testStartGame() throws {
        let gameWorld = try XCTUnwrap(testGameWorld)

        XCTAssertNil(gameWorld.level.mainPlatform)
        XCTAssertNil(gameWorld.level.leftBoundary)
        XCTAssertNil(gameWorld.level.rightBoundary)
        XCTAssertNil(gameWorld.level.powerupLine)
        XCTAssertNil(gameWorld.currentlyMovingBlock)

        gameWorld.startGame()

        XCTAssertNotNil(gameWorld.level.mainPlatform)
        XCTAssertNotNil(gameWorld.level.leftBoundary)
        XCTAssertNotNil(gameWorld.level.rightBoundary)
        XCTAssertNotNil(gameWorld.level.powerupLine)
        XCTAssertNotNil(gameWorld.currentlyMovingBlock)
    }

    func testResetGame() throws {
        let gameWorld = try XCTUnwrap(testGameWorld)

        gameWorld.startGame()

        XCTAssertNotNil(gameWorld.level.mainPlatform)
        XCTAssertNotNil(gameWorld.level.leftBoundary)
        XCTAssertNotNil(gameWorld.level.rightBoundary)
        XCTAssertNotNil(gameWorld.level.powerupLine)
        XCTAssertNotNil(gameWorld.currentlyMovingBlock)

        gameWorld.resetGame()

        XCTAssertNil(gameWorld.level.mainPlatform)
        XCTAssertNil(gameWorld.level.leftBoundary)
        XCTAssertNil(gameWorld.level.rightBoundary)
        XCTAssertNil(gameWorld.level.powerupLine)
        XCTAssertNil(gameWorld.currentlyMovingBlock)
        XCTAssertEqual(gameWorld.level.gameObjects.count, 0)
    }

    func testEndGame() throws {
        let gameWorld = try XCTUnwrap(testGameWorld)

        gameWorld.startGame()

        XCTAssertNotNil(gameWorld.level.mainPlatform)
        XCTAssertNotNil(gameWorld.level.leftBoundary)
        XCTAssertNotNil(gameWorld.level.rightBoundary)
        XCTAssertNotNil(gameWorld.level.powerupLine)
        XCTAssertNotNil(gameWorld.currentlyMovingBlock)

        gameWorld.endGame()

        XCTAssertNil(gameWorld.level.mainPlatform)
        XCTAssertNil(gameWorld.level.leftBoundary)
        XCTAssertNil(gameWorld.level.rightBoundary)
        XCTAssertNil(gameWorld.level.powerupLine)
        XCTAssertNil(gameWorld.currentlyMovingBlock)
        XCTAssertEqual(gameWorld.level.gameObjects.count, 0)
    }

//    func testSetCMBSpecialProperties() throws {
//        let gameWorld = try XCTUnwrap(testGameWorld)
//
//        gameWorld.startGame()
//
//
//    }

}
