//
//  GameFiziksBodyTestsB.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 2/4/23.
//

import XCTest
@testable import Fiziks

final class GameFiziksBodyTestsB: XCTestCase {
    var fiziksBody: GameFiziksBody!
    var fiziksShapeNode: FiziksShapeNode!
    static let points: [CGPoint] = [CGPoint(x: 0, y: 0),
                                    CGPoint(x: 10, y: 0),
                                    CGPoint(x: 10, y: 10),
                                    CGPoint(x: 30, y: 10),
                                    CGPoint(x: 30, y: 20),
                                    CGPoint(x: 0, y: 20)]
    let path = CGPath.create(from: GameFiziksBodyTestsA.points)

    override func setUp() {
        super.setUp()
        fiziksBody = GameFiziksBody(path: path,
                                    position: .zero,
                                    zRotation: 5,
                                    isDynamic: true,
                                    categoryBitMask: 0x1,
                                    collisionBitMask: 0x1,
                                    contactTestBitMask: 0x1)
        fiziksShapeNode = fiziksBody.fiziksShapeNode
    }

    func testGetArea_bothSameValue() {
        let currFSNValue = fiziksShapeNode.area
        let currPFBValue = fiziksBody.area
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testGetFriction_bothSameValue() {
        let currFSNValue = fiziksShapeNode.friction
        let currPFBValue = fiziksBody.friction
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetFriction_setsBothValues() throws {
        let currFSNValue = fiziksShapeNode.friction
        let currPFBValue = fiziksBody.friction
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.friction = newTestValue
        let newFSNValue = try XCTUnwrap(fiziksShapeNode.friction)
        let newPFBValue = try XCTUnwrap(fiziksBody.friction)
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }

    func testGetRestitution_bothSameValue() {
        let currFSNValue = fiziksShapeNode.restitution
        let currPFBValue = fiziksBody.restitution
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetRestutution_setsBothValues() throws {
        let currFSNValue = fiziksShapeNode.restitution
        let currPFBValue = fiziksBody.restitution
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.restitution = newTestValue
        let newFSNValue = try XCTUnwrap(fiziksShapeNode.restitution)
        let newPFBValue = try XCTUnwrap(fiziksBody.restitution)
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }

    func testGetLinearDamping_bothSameValue() {
        let currFSNValue = fiziksShapeNode.linearDamping
        let currPFBValue = fiziksBody.linearDamping
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetLinearDamping_setsBothValues() throws {
        let currFSNValue = fiziksShapeNode.linearDamping
        let currPFBValue = fiziksBody.linearDamping
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.linearDamping = newTestValue
        let newFSNValue = try XCTUnwrap(fiziksShapeNode.linearDamping)
        let newPFBValue = try XCTUnwrap(fiziksBody.linearDamping)
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }

    func testGetAngularDamping_bothSameValue() {
        let currFSNValue = fiziksShapeNode.angularDamping
        let currPFBValue = fiziksBody.angularDamping
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetAngularDamping_setsBothValues() throws {
        let currFSNValue = fiziksShapeNode.angularDamping
        let currPFBValue = fiziksBody.angularDamping
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.angularDamping = newTestValue
        let newFSNValue = try XCTUnwrap(fiziksShapeNode.angularDamping)
        let newPFBValue = try XCTUnwrap(fiziksBody.angularDamping)
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }

    func testGetCategoryBitMask_bothSameValue() {
        let currFSNValue = fiziksShapeNode.categoryBitMask
        let currPFBValue = fiziksBody.categoryBitMask
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetCategoryBitMask_setsBothValues() {
        let currFSNValue = fiziksShapeNode.categoryBitMask
        let currPFBValue = fiziksBody.categoryBitMask
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue: BitMask = 0xFFFFFFFF
        assert(newTestValue != currFSNValue)

        fiziksBody.categoryBitMask = newTestValue
        let newFSNValue = fiziksShapeNode.categoryBitMask
        let newPFBValue = fiziksBody.categoryBitMask
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetCollisionBitMask_bothSameValue() {
        let currFSNValue = fiziksShapeNode.collisionBitMask
        let currPFBValue = fiziksBody.collisionBitMask
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetCollisionBitMask_setsBothValues() {
        let currFSNValue = fiziksShapeNode.collisionBitMask
        let currPFBValue = fiziksBody.collisionBitMask
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue: BitMask = 0xFFFFFFFF
        assert(newTestValue != currFSNValue)

        fiziksBody.collisionBitMask = newTestValue
        let newFSNValue = fiziksShapeNode.collisionBitMask
        let newPFBValue = fiziksBody.collisionBitMask
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetContactTestBitMask_bothSameValue() {
        let currFSNValue = fiziksShapeNode.contactTestBitMask
        let currPFBValue = fiziksBody.contactTestBitMask
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetContactTestBitMask_setsBothValues() {
        let currFSNValue = fiziksShapeNode.contactTestBitMask
        let currPFBValue = fiziksBody.contactTestBitMask
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue: BitMask = 0xFFFFFFFF
        assert(newTestValue != currFSNValue)

        fiziksBody.contactTestBitMask = newTestValue
        let newFSNValue = fiziksShapeNode.contactTestBitMask
        let newPFBValue = fiziksBody.contactTestBitMask
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetUsesPreciseCollisionDetection_bothSameValue() {
        let currFSNValue = fiziksShapeNode.usesPreciseCollisionDetection
        let currPFBValue = fiziksBody.usesPreciseCollisionDetection
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetUsesPreciseCollisionDetection_setsBothValues() {
        let currFSNValue = fiziksShapeNode.usesPreciseCollisionDetection
        let currPFBValue = fiziksBody.usesPreciseCollisionDetection
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = true
        assert(newTestValue != currFSNValue)

        fiziksBody.usesPreciseCollisionDetection = newTestValue
        let newFSNValue = fiziksShapeNode.usesPreciseCollisionDetection
        let newPFBValue = fiziksBody.usesPreciseCollisionDetection
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

}
