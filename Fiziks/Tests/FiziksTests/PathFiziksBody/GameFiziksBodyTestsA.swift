//
//  MyTest.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 2/4/23.
//

import XCTest
@testable import Fiziks

final class GameFiziksBodyTestsA: XCTestCase {
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
        fiziksBody = GameFiziksBody(path: path,
                                    position: .zero,
                                    zRotation: 5,
                                    isDynamic: true,
                                    categoryBitMask: 0x1,
                                    collisionBitMask: 0x1,
                                    contactTestBitMask: 0x1)
        fiziksShapeNode = fiziksBody.fiziksShapeNode
    }
    
    func testGetPosition_bothSameValue() {
        let currFSNValue = fiziksShapeNode.position
        let currPFBValue = fiziksBody.position
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetPosition_setsBothValues() {
        let currFSNValue = fiziksShapeNode.position
        let currPFBValue = fiziksBody.position
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGPoint(x: 100, y: 100)
        assert(newTestValue != currFSNValue)

        fiziksBody.position = newTestValue
        let newFSNValue = fiziksShapeNode.position
        let newPFBValue = fiziksBody.position
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetZRotation_bothSameValue() {
        let currFSNValue = fiziksShapeNode.zRotation
        let currPFBValue = fiziksBody.zRotation
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetZRotation_setsBothValues() {
        let currFSNValue = fiziksShapeNode.zRotation
        let currPFBValue = fiziksBody.zRotation
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.zRotation = newTestValue
        let newFSNValue = fiziksShapeNode.zRotation
        let newPFBValue = fiziksBody.zRotation
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }

    func testGetVelocity_bothSameValue() {
        let currFSNValue = fiziksShapeNode.velocity
        let currPFBValue = fiziksBody.velocity
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetVelocity_setsBothValues() {
        let currFSNValue = fiziksShapeNode.velocity
        let currPFBValue = fiziksBody.velocity
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGVector(dx: 100, dy: 100)
        assert(newTestValue != currFSNValue)

        fiziksBody.velocity = newTestValue
        let newFSNValue = fiziksShapeNode.velocity
        let newPFBValue = fiziksBody.velocity
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetAngularVelocity_bothSameValue() {
        let currFSNValue = fiziksShapeNode.angularVelocity
        let currPFBValue = fiziksBody.angularVelocity
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetAngularVelocity_setsBothValues() throws {
        let currFSNValue = fiziksShapeNode.angularVelocity
        let currPFBValue = fiziksBody.angularVelocity
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.angularVelocity = newTestValue
        let newFSNValue = try XCTUnwrap(fiziksShapeNode.angularVelocity)
        let newPFBValue = try XCTUnwrap(fiziksBody.angularVelocity)
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }

    func testGetIsResting_bothSameValue() {
        let currFSNValue = fiziksShapeNode.isResting
        let currPFBValue = fiziksBody.isResting
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetIsResting_setsBothValues() {
        let currFSNValue = fiziksShapeNode.isResting
        let currPFBValue = fiziksBody.isResting
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = false
        assert(newTestValue != currFSNValue)

        fiziksBody.isResting = newTestValue
        let newFSNValue = fiziksShapeNode.isResting
        let newPFBValue = fiziksBody.isResting
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetAffectedByGravity_bothSameValue() {
        let currFSNValue = fiziksShapeNode.affectedByGravity
        let currPFBValue = fiziksBody.affectedByGravity
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetAffectedByGravity_setsBothValues() {
        let currFSNValue = fiziksShapeNode.affectedByGravity
        let currPFBValue = fiziksBody.affectedByGravity
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = false
        assert(newTestValue != currFSNValue)

        fiziksBody.affectedByGravity = newTestValue
        let newFSNValue = fiziksShapeNode.affectedByGravity
        let newPFBValue = fiziksBody.affectedByGravity
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetAllowsRotation_bothSameValue() {
        let currFSNValue = fiziksShapeNode.allowsRotation
        let currPFBValue = fiziksBody.allowsRotation
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetAllowsRotation_setsBothValues() {
        let currFSNValue = fiziksShapeNode.allowsRotation
        let currPFBValue = fiziksBody.allowsRotation
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = false
        assert(newTestValue != currFSNValue)

        fiziksBody.allowsRotation = newTestValue
        let newFSNValue = fiziksShapeNode.allowsRotation
        let newPFBValue = fiziksBody.allowsRotation
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetIsDynamic_bothSameValue() {
        let currFSNValue = fiziksShapeNode.isDynamic
        let currPFBValue = fiziksBody.isDynamic
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetIsDynamic_setsBothValues() {
        let currFSNValue = fiziksShapeNode.isDynamic
        let currPFBValue = fiziksBody.isDynamic
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = false
        assert(newTestValue != currFSNValue)

        fiziksBody.isDynamic = newTestValue
        let newFSNValue = fiziksShapeNode.isDynamic
        let newPFBValue = fiziksBody.isDynamic
        XCTAssertEqual(newPFBValue, newTestValue)
        XCTAssertEqual(newFSNValue, newTestValue)
    }

    func testGetMass_bothSameValue() {
        let currFSNValue = fiziksShapeNode.mass
        let currPFBValue = fiziksBody.mass
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetMass_setsBothValues() throws {
        let currFSNValue = fiziksShapeNode.mass
        let currPFBValue = fiziksBody.mass
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.mass = newTestValue
        let newFSNValue = try XCTUnwrap(fiziksShapeNode.mass)
        let newPFBValue = try XCTUnwrap(fiziksBody.mass)
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }

    func testGetDensity_bothSameValue() {
        let currFSNValue = fiziksShapeNode.density
        let currPFBValue = fiziksBody.density
        XCTAssertEqual(currFSNValue, currPFBValue)
    }

    func testSetDensity_setsBothValues() throws {
        let currFSNValue = fiziksShapeNode.density
        let currPFBValue = fiziksBody.density
        XCTAssertEqual(currFSNValue, currPFBValue)

        let newTestValue = CGFloat(1.3)
        assert(newTestValue != currFSNValue)

        fiziksBody.density = newTestValue
        let newFSNValue = try XCTUnwrap(fiziksShapeNode.density)
        let newPFBValue = try XCTUnwrap(fiziksBody.density)
        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
    }
}
