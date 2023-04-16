//
//  GameFiziksEngineTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import XCTest
import SpriteKit
@testable import Fiziks

class GameFiziksEngineTests: XCTestCase {
    let defaultLevelDimensions = CGRect(x: 0, y: 0, width: 500, height: 500)
    var engine: GameFiziksEngine?
    let skView = SKView()
    let delegate = MockFiziksContactDelegate()
    let fiziksBody: FiziksBody = MockFiziksBody()

    override func setUp() {
        engine = GameFiziksEngine(size: defaultLevelDimensions)
        engine?.fiziksContactDelegate = delegate
    }

    func test_construct() {
        guard let fiziksScene = engine?.fiziksScene,
              let contactDelegate = engine?.fiziksContactDelegate else {
            return XCTFail("""
                           GameFiziksEngine constructor should have automatically
                           created a FiziksScene and fiziksConatactDelegate should
                           have been successfully set.
                           """)
        }

        let cgSize = CGSize(width: defaultLevelDimensions.width, height: defaultLevelDimensions.height)

        XCTAssertEqual(fiziksScene.size, cgSize)
        XCTAssertNotNil(engine?.idToFiziksBody)
        XCTAssertNotNil(engine?.skNodeToFiziksBody)
        XCTAssertTrue(contactDelegate === delegate)
        XCTAssertTrue(fiziksScene.physicsWorld.contactDelegate === engine)
    }

    func test_add() throws {
        let id = ObjectIdentifier(fiziksBody)
        engine?.add(fiziksBody)

        let addedFiziksBody = try XCTUnwrap(engine?.idToFiziksBody[id])
        XCTAssertEqual(id, ObjectIdentifier(addedFiziksBody))
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

    func testCombine() {
        let fiziksBodyB = MockFiziksBody()

        engine?.add(fiziksBody)
        engine?.add(fiziksBodyB)

        engine?.combine(bodyA: fiziksBody, bodyB: fiziksBodyB)

        XCTAssertTrue(engine?.contains(fiziksBody) ?? false)
        XCTAssertTrue(engine?.contains(fiziksBodyB) ?? false)
    }

    func testSetWorldGravity() {
        let newGravity = CGVector(dx: 0, dy: 1_000)
        XCTAssertNotEqual(newGravity, engine?.fiziksScene.gravity)

        engine?.setWorldGravity(to: newGravity)

        XCTAssertEqual(newGravity, engine?.fiziksScene.gravity)
    }
}
