//
//  GameFiziksEngineTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import Foundation
import XCTest
import SpriteKit

class GameFiziksEngineTests: XCTest {
    let defaultLevelDimensions: CGRect = CGRect(x: 0, y: 0, width: 500, height: 500)
    var engine: GameFiziksEngine?
    let skView: SKView = SKView()
    let delegate: MockFiziksContactDelegate = MockFiziksContactDelegate()
    let fiziksBody: FiziksBody = MockFiziksBody()
    
    override func setUp() {
        engine = GameFiziksEngine(levelDimensions: defaultLevelDimensions, boundingRect: defaultLevelDimensions)
        engine?.fiziksContactDelegate = delegate
    }
    
    func test_construct() {
        guard let fiziksScene = engine?.fiziksScene,
              let contactDelegate = engine?.fiziksContactDelegate else {
            return XCTFail()
        }
        
        let cgSize = CGSize(width: defaultLevelDimensions.width, height: defaultLevelDimensions.height)
        
        XCTAssertEqual(fiziksScene.size, cgSize)
        XCTAssertNotNil(engine?.fiziksBodyIdToFiziksBody)
        XCTAssertNotNil(engine?.fiziksBodyIdToFiziksBody)
        XCTAssertTrue(contactDelegate === delegate)
        XCTAssertTrue(fiziksScene.physicsWorld.contactDelegate === engine)
        XCTAssertTrue(fiziksScene.fiziksSceneUpdateDelegate === engine)
    }
    
    func test_activatePhysics() {
        engine?.activatePhysics()
        
        XCTAssertTrue(engine?.fiziksScene.view?.showsPhysics ?? false)
    }
    
    func test_add() {
        let id = ObjectIdentifier(fiziksBody)
        engine?.add(fiziksBody)
        
        XCTAssertNotNil(engine?.fiziksBodyIdToSKNode[key: id])
        XCTAssertNotNil(engine?.fiziksBodyIdToFiziksBody[id])
    }
    
    func test_contains() {
        XCTAssertFalse(engine?.contains(fiziksBody) ?? true)
        
        engine?.add(fiziksBody)
        
        XCTAssertTrue(engine?.contains(fiziksBody) ?? false)
    }
    
    func test_delete() {
        engine?.add(fiziksBody)
        XCTAssertTrue(engine?.contains(fiziksBody) ?? false)
        
        engine?.delete(fiziksBody)
        XCTAssertFalse(engine?.contains(fiziksBody) ?? true)
    }
    
    func test_move_doesNotMoveNotAddedBody() {
        let initialPos: CGPoint = fiziksBody.position
        let newPos = CGPoint(x: 100, y: 100)
        
        XCTAssertNotEqual(newPos, initialPos)
        
        // should do nothing
        engine?.move(fiziksBody, to: newPos)
        
        XCTAssertEqual(fiziksBody.position, initialPos)
    }
    
    func test_move_updatesBodyPosition() {
        let initialPos: CGPoint = fiziksBody.position
        let newPos = CGPoint(x: 100, y: 100)
        
        engine?.add(fiziksBody)
        
        XCTAssertNotEqual(newPos, initialPos)
        
        engine?.move(fiziksBody, to: newPos)
        
        XCTAssertEqual(fiziksBody.position, newPos)
    }
    
    func test_move_doesNotMoveNotAddedBodyDisplacement() {
        let initialPos: CGPoint = fiziksBody.position
        let displacement = CGVector(dx: 100, dy: 100)
        let newPos = CGPoint(x: initialPos.x + displacement.dx,
                             y: initialPos.y + displacement.dy)
        
        XCTAssertNotEqual(newPos, initialPos)
        
        // should do nothing
        engine?.move(fiziksBody, by: displacement)
        
        XCTAssertEqual(fiziksBody.position, initialPos)
    }
    
    func test_move_updatesBodyPositionDisplacement() {
        let initialPos: CGPoint = fiziksBody.position
        let displacement = CGVector(dx: 100, dy: 100)
        let newPos = CGPoint(x: initialPos.x + displacement.dx,
                             y: initialPos.y + displacement.dy)
        
        engine?.add(fiziksBody)
        
        XCTAssertNotEqual(newPos, initialPos)
        
        engine?.move(fiziksBody, by: displacement)
        
        XCTAssertEqual(fiziksBody.position, newPos)
    }
    
    func testCombine() {
        let fiziksBodyB = MockFiziksBody()
        
        engine?.add(fiziksBodyB)
        
        engine?.combine([fiziksBody, fiziksBodyB])
        
        XCTAssertFalse(engine?.contains(fiziksBody) ?? true)
        XCTAssertFalse(engine?.contains(fiziksBodyB) ?? true)
        XCTAssertEqual(engine?.fiziksBodyIdToFiziksBody.count, 1)
    }
    
    func testRotate() {
        let newAngle = 5.0
        XCTAssertNotEqual(newAngle, fiziksBody.zRotation)
        
        engine?.add(fiziksBody)
        engine?.rotate(fiziksBody, by: 5.0)
        
        XCTAssertEqual(fiziksBody.zRotation, newAngle)
    }
    
    func testRotate_doesNothing_bodyNotInEngine() {
        let newAngle = 5.0
        XCTAssertNotEqual(newAngle, fiziksBody.zRotation)
        
        // does nothing
        engine?.rotate(fiziksBody, by: 5.0)
        
        XCTAssertEqual(fiziksBody.zRotation, newAngle)
    }
    
    func testGetPosition() {
        XCTAssertNil(engine?.getPosition(of: fiziksBody))
        
        engine?.add(fiziksBody)
        
        XCTAssertEqual(engine?.getPosition(of: fiziksBody), fiziksBody.position)
    }
    
    func testSetDynamic() {
        engine?.add(fiziksBody)
        
        XCTAssertTrue(fiziksBody.isDynamic)
        XCTAssertTrue(engine?.isDynamic(fiziksBody) ?? false)
        
        engine?.setDynamicValue(fiziksBody, to: false)
        
        XCTAssertFalse(fiziksBody.isDynamic)
        XCTAssertFalse(engine?.isDynamic(fiziksBody) ?? true)
        
        engine?.setDynamicValue(fiziksBody, to: true)
        
        XCTAssertTrue(fiziksBody.isDynamic)
        XCTAssertTrue(engine?.isDynamic(fiziksBody) ?? false)
    }
    
    func testSetAffectedByGravity() {
        engine?.add(fiziksBody)
        engine?.setAffectedByGravity(fiziksBody, to: true)
        
        guard let nodePhysicsBody = engine?.fiziksBodyIdToSKNode[key: ObjectIdentifier(fiziksBody)]?.physicsBody else {
            return XCTFail()
        }
        
        XCTAssertTrue(nodePhysicsBody.affectedByGravity)
        
        engine?.setAffectedByGravity(fiziksBody, to: false)
        XCTAssertFalse(nodePhysicsBody.affectedByGravity)
    }
    
    func testSetVelocity() {
        engine?.add(fiziksBody)
        guard let nodePhysicsBody = engine?.fiziksBodyIdToSKNode[key: ObjectIdentifier(fiziksBody)]?.physicsBody else {
            return XCTFail()
        }
        let newVelocity = CGVector(dx: 5.0, dy: 5.0)
        XCTAssertNotEqual(newVelocity, nodePhysicsBody.velocity)
        
        engine?.setVelocity(fiziksBody, to: newVelocity)
        
        XCTAssertEqual(nodePhysicsBody.velocity, newVelocity)
    }
    
    func setWorldGravity() {
        let newGravity = CGVector(dx: 0, dy: 1000)
        XCTAssertNotEqual(newGravity, engine?.fiziksScene.gravity)
        
        engine?.setWorldGravity(to: newGravity)
        
        XCTAssertEqual(newGravity, engine?.fiziksScene.gravity)
    }
    
    func testUpdateAllFiziksBodies() {
        engine?.add(fiziksBody)
        let newPosition = CGPoint(x: 5.0, y: 5.0)
        let newRotation = 5.0
        
        guard let skNode = engine?.fiziksBodyIdToSKNode[key: ObjectIdentifier(fiziksBody)] else {
            return XCTFail()
        }
        
        XCTAssertNotEqual(fiziksBody.position, newPosition)
        XCTAssertNotEqual(fiziksBody.zRotation, newRotation)
        
        skNode.position = newPosition
        skNode.zRotation = newRotation
        
        XCTAssertNotEqual(fiziksBody.position, skNode.position)
        XCTAssertNotEqual(fiziksBody.zRotation, skNode.zRotation)
        
        engine?.updateAllFiziksBodies()
        
        XCTAssertEqual(fiziksBody.position, skNode.position)
        XCTAssertEqual(fiziksBody.zRotation, skNode.zRotation)
    }
}
