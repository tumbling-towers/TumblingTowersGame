//
//  GameEngineTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 16/4/23.
//

import Foundation
import XCTest
@testable import TumblingTowersGame

final class GameEngineTests: XCTestCase {

    var testGameEngine: GameEngine?
    var eventManager: EventManager?
    var playerId: UUID?
    var gameMode: MockGameMode?

    override func setUp() {
        super.setUp()
        let levelDimensions = CGRect(x: 0, y: 0, width: 500, height: 500)
        let mockEventManager = MockEventManager()
        eventManager = mockEventManager

        let newPlayerId = UUID()
        playerId = newPlayerId

        let gameEngine = GameEngine(levelDimensions: levelDimensions,
                                    eventManager: mockEventManager,
                                    playerId: newPlayerId,
                                    storageManager: StorageManager(),
                                    playersMode: .singleplayer)

        let mockGameMode = MockGameMode(eventMgr: mockEventManager,
                                        playerId: newPlayerId,
                                        levelHeight: levelDimensions.height)
        gameMode = mockGameMode

        gameEngine.gameMode = mockGameMode

        testGameEngine = gameEngine
    }

    func test_moveCMBDown() throws {
        let displacement = CGVector(dx: 0, dy: -10)
        let gameEngine = try XCTUnwrap(testGameEngine)

        gameEngine.startGame()
        let cmbPosition = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.position)

        gameEngine.moveCMBDown(by: displacement)

        let expectedCMBPosition = cmbPosition.add(by: displacement)

        XCTAssertEqual(expectedCMBPosition, gameEngine.gameWorld.currentlyMovingBlock?.position)
    }

    func test_moveCMBDown_dy_gt0() throws {
        let displacement = CGVector(dx: 0, dy: 10)
        let gameEngine = try XCTUnwrap(testGameEngine)

        gameEngine.startGame()
        let cmbPosition = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.position)

        gameEngine.moveCMBDown(by: displacement)

        // shouldn't move
        XCTAssertEqual(cmbPosition, gameEngine.gameWorld.currentlyMovingBlock?.position)
    }

    func test_moveCMBDown_dx_gt0() throws {
        let displacement = CGVector(dx: 10, dy: -10)
        let gameEngine = try XCTUnwrap(testGameEngine)

        gameEngine.startGame()
        let cmbPosition = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.position)

        gameEngine.moveCMBDown(by: displacement)

        let expectedCMBPosition = CGPoint(x: cmbPosition.x, y: cmbPosition.y + displacement.dy)

        // shouldn't move horizontally
        XCTAssertEqual(expectedCMBPosition, gameEngine.gameWorld.currentlyMovingBlock?.position)
    }

    func test_moveCMBDown_dx_lt0() throws {
        let displacement = CGVector(dx: -10, dy: -10)
        let gameEngine = try XCTUnwrap(testGameEngine)

        gameEngine.startGame()
        let cmbPosition = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.position)

        gameEngine.moveCMBDown(by: displacement)

        let expectedCMBPosition = CGPoint(x: cmbPosition.x, y: cmbPosition.y + displacement.dy)

        // shouldn't move horizontally
        XCTAssertEqual(expectedCMBPosition, gameEngine.gameWorld.currentlyMovingBlock?.position)
    }

    func test_rotateClockwise() throws {
        let gameEngine = try XCTUnwrap(testGameEngine)

        gameEngine.startGame()
        let rotation = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.rotation)

        gameEngine.rotateCMBClockwise()

        let expectedRotation = rotation + -CGFloat.pi / 2
        let updatedRotation = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.rotation)

        XCTAssertEqual(updatedRotation, expectedRotation, accuracy: 1e-4)
    }

    func test_rotateCounterClockwise() throws {
        let gameEngine = try XCTUnwrap(testGameEngine)

        gameEngine.startGame()
        let rotation = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.rotation)

        gameEngine.rotateCMBCounterClockwise()
        let expectedRotation = rotation + CGFloat.pi / 2
        let updatedRotation = try XCTUnwrap(gameEngine.gameWorld.currentlyMovingBlock?.rotation)

        XCTAssertEqual(updatedRotation, expectedRotation, accuracy: 1e-4)
    }

    func testUpdate() throws {
        let gameMode = try XCTUnwrap(gameMode)

        XCTAssertFalse(gameMode.isUpdated)

        testGameEngine?.update()

        XCTAssertTrue(gameMode.isUpdated)
    }

    func testResetGame() throws {
        let gameEngine = try XCTUnwrap(testGameEngine)
        let gameWorld = gameEngine.gameWorld
        let gameMode = try XCTUnwrap(gameMode)

        gameEngine.startGame()

        XCTAssertNotNil(gameWorld.level.mainPlatform)
        XCTAssertNotNil(gameWorld.level.leftBoundary)
        XCTAssertNotNil(gameWorld.level.rightBoundary)
        XCTAssertNotNil(gameWorld.level.powerupLine)
        XCTAssertNotNil(gameWorld.currentlyMovingBlock)

        XCTAssertFalse(gameMode.isGameReset)

        gameEngine.resetGame()

        XCTAssertNil(gameWorld.level.mainPlatform)
        XCTAssertNil(gameWorld.level.leftBoundary)
        XCTAssertNil(gameWorld.level.rightBoundary)
        XCTAssertNil(gameWorld.level.powerupLine)
        XCTAssertNil(gameWorld.currentlyMovingBlock)
        XCTAssertEqual(gameWorld.level.gameObjects.count, 0)

        XCTAssertTrue(gameMode.isGameReset)
    }
}
