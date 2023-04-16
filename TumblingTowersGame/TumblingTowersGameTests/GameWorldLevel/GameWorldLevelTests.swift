//
//  GameWorldLevel.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 16/4/23.
//

import Foundation
import XCTest
import Fiziks
@testable import TumblingTowersGame

final class GameWorldLevelTests: XCTestCase {
    var testGameWorldLevel: GameWorldLevel?
    
    override func setUp() {
        let levelDimensions = CGRect(x: 0, y: 0, width: 500, height: 500)
        
        let level = GameWorldLevel(levelDimensions: levelDimensions)
        
        testGameWorldLevel = level
    }
    
    func testConstruct() {
        let levelDimensions = CGRect(x: 0, y: 0, width: 500, height: 500)
        
        let level = GameWorldLevel(levelDimensions: levelDimensions)
        
        XCTAssertEqual(level.gameObjects.count, 0)
        XCTAssertEqual(level.dimensions, levelDimensions)
    }
    
    func testAdd() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let shape = GamePathObjectShape(path: CGPath(rect: .zero, transform: nil))
        
        let object = Platform(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        
        XCTAssertEqual(level.gameObjects.count, 0)
        
        level.add(gameWorldObject: object)
        
        XCTAssertEqual(level.gameObjects.count, 1)
    }
    
    func testRemove() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let shape = GamePathObjectShape(path: CGPath(rect: .zero, transform: nil))
        let object = Platform(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        
        level.gameObjects = [object]
        
        XCTAssertEqual(level.gameObjects.count, 1)
        
        level.remove(gameWorldObject: object)
        
        XCTAssertEqual(level.gameObjects.count, 0)
    }
    
    func testMove() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let shape = GamePathObjectShape(path: CGPath(rect: .zero, transform: nil))
        let object = Block(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        
        level.add(gameWorldObject: object)
        
        let displacement = CGVector(dx: 10, dy: 10)
        let position = object.position
        
        level.move(gameWorldObject: object, by: displacement)
        
        let expectedPosition = position.add(by: displacement)
        XCTAssertEqual(expectedPosition, object.position)
    }
    
    func testRotate() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let shape = GamePathObjectShape(path: CGPath(rect: .zero, transform: nil))
        let object = Platform(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        
        level.gameObjects = [object]
        
        let rotation = object.rotation
        
        level.rotate(gameWorldObject: object, by: 10)
        
        let expectedRotation = rotation + 10
        XCTAssertEqual(expectedRotation, object.rotation)
    }
    
    func testReset() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let shape = GamePathObjectShape(path: CGPath(rect: .zero, transform: nil))
        let platform = Platform(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        
        level.mainPlatform = platform
        level.add(gameWorldObject: platform)
        
        level.powerupLine = PowerupLine(position: .zero, dimensions: .zero)
        
        let leftBoundary = LevelBoundary(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        let rightBoundary = LevelBoundary(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        
        level.add(gameWorldObject: leftBoundary)
        level.add(gameWorldObject: rightBoundary)
        
        level.leftBoundary = leftBoundary
        level.rightBoundary = rightBoundary
        
        XCTAssertNotNil(level.mainPlatform)
        XCTAssertNotNil(level.powerupLine)
        XCTAssertNotNil(level.leftBoundary)
        XCTAssertNotNil(level.rightBoundary)
        XCTAssertEqual(level.gameObjects.count, 3)
        
        level.reset()
        
        XCTAssertNil(level.mainPlatform)
        XCTAssertNil(level.powerupLine)
        XCTAssertNil(level.leftBoundary)
        XCTAssertNil(level.rightBoundary)
        XCTAssertEqual(level.gameObjects.count, 0)
    }
    
    func testSetMainPlatform() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let shape = GamePathObjectShape(path: CGPath(rect: .zero, transform: nil))
        let platform = Platform(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
        
        XCTAssertNil(level.mainPlatform)
        XCTAssertEqual(level.gameObjects.count, 0)
        
        level.setMainPlatform(platform: platform)
        
        XCTAssertEqual(level.mainPlatform, platform)
        XCTAssertEqual(level.gameObjects.count, 1)
    }
    
    func testUpdatePowerupLineHeight() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let powerupLine = PowerupLine(position: .zero, dimensions: .zero)
        level.powerupLine = powerupLine
        let position = powerupLine.position
        
        level.updatePowerupLineHeight()
        
        let expectedPosition = position.add(by: CGVector(dx: 0, dy: GameWorldConstants.defaultPowerupHeightStep))
        XCTAssertEqual(level.powerupLine?.position, expectedPosition)
    }
    
    func testIsOutOfBounds() {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let shape = GamePathObjectShape(path: CGPath(rect: rect, transform: nil))
        let block = Block(fiziksBody: GameFiziksBody(rect: rect), shape: shape)
        let levelDimensions = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let level = GameWorldLevel(levelDimensions: levelDimensions)
        
        // block pos (0,0)
        XCTAssertFalse(level.isOutOfBounds(block))
        
        // block pos (-100, 0)
        level.move(gameWorldObject: block, by: CGVector(dx: -100, dy: 0))
        XCTAssertEqual(block.position, CGPoint(x: -100, y: 0))
        XCTAssertFalse(level.isOutOfBounds(block))
        
        // block pos (-101, 0)
        level.move(gameWorldObject: block, by: CGVector(dx: -1, dy: 0))
        XCTAssertEqual(block.position, CGPoint(x: -101, y: 0))
        XCTAssertTrue(level.isOutOfBounds(block))
        
        // block pos (0, -100)
        level.move(gameWorldObject: block, by: CGVector(dx: 101, dy: -100))
        XCTAssertEqual(block.position, CGPoint(x: 0, y: -100))
        XCTAssertFalse(level.isOutOfBounds(block))
        
        // block pos (0, -101)
        level.move(gameWorldObject: block, by: CGVector(dx: 0, dy: -1))
        XCTAssertEqual(block.position, CGPoint(x: 0, y: -101))
        XCTAssertTrue(level.isOutOfBounds(block))
        
        // block pos (0, 201)
        level.move(gameWorldObject: block, by: CGVector(dx: 0, dy: 101 + 201))
        XCTAssertEqual(block.position, CGPoint(x: 0, y: 201))
        XCTAssertFalse(level.isOutOfBounds(block))
    }
    
    func testGetHighestPoint() throws {
        let level = try XCTUnwrap(testGameWorldLevel)
        let rect = CGRect(x: 10, y: 10, width: 100, height: 100)
        let shape = GamePathObjectShape(path: CGPath(rect: rect, transform: nil))
        let block = Block(fiziksBody: GameFiziksBody(rect: rect), shape: shape)
        
        level.add(gameWorldObject: block)
        XCTAssertEqual(level.getHighestPoint(excluding: block), -Double.infinity)
        XCTAssertEqual(level.getHighestPoint(), block.position.y + block.height / 2)
    }
}
