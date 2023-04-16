//
//  GameWorldLevel.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 16/4/23.
//

import Foundation
import XCTest
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
    
//    func testMove() throws {
//        let level = try XCTUnwrap(testGameWorldLevel)
//        let shape = GamePathObjectShape(path: CGPath(rect: .zero, transform: nil))
//        let object = Block(fiziksBody: GameFiziksBody(rect: .zero), shape: shape)
//
//        level.add(gameWorldObject: object)
//
//        let displacement = CGVector(dx: 10, dy: 10)
//        let position = object.position
//
//        level.move(gameWorldObject: object, by: displacement)
//
//        let expectedPosition = position.add(by: displacement)
//        XCTAssertEqual(expectedPosition, object.position)
//    }
    
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
}
