////
////  PathFiziksBodyTestsB.swift
////  TumblingTowersGameTests
////
////  Created by Quan Teng Foong on 2/4/23.
////
//
//import XCTest
//@testable import TumblingTowersGame
//
//final class PathFiziksBodyTestsB: XCTestCase {
//    var pathBody: PathFiziksBody!
//    var fiziksShapeNode: FiziksShapeNode!
//    static let points: [CGPoint] = [CGPoint(x: 0, y: 0),
//                                    CGPoint(x: 10, y: 0),
//                                    CGPoint(x: 10, y: 10),
//                                    CGPoint(x: 30, y: 10),
//                                    CGPoint(x: 30, y: 20),
//                                    CGPoint(x: 0, y: 20)]
//    let path = CGPath.create(from: PathFiziksBodyTestsA.points)
//
//    override func setUp() {
//        pathBody = PathFiziksBody(path: path,
//                                  position: .zero,
//                                  zRotation: 5,
//                                  isDynamic: true,
//                                  categoryBitMask: 0x1,
//                                  collisionBitMask: 0x1,
//                                  contactTestBitMask: 0x1)
//        fiziksShapeNode = pathBody.fiziksShapeNode
//    }
//
//    func testGetArea_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.area
//        let currPFBValue = pathBody.area
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testGetFriction_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.friction
//        let currPFBValue = pathBody.friction
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetFriction_setsBothValues() throws {
//        let currFSNValue = fiziksShapeNode.friction
//        let currPFBValue = pathBody.friction
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = CGFloat(1.3)
//        assert(newTestValue != currFSNValue)
//
//        pathBody.friction = newTestValue
//        let newFSNValue = try XCTUnwrap(fiziksShapeNode.friction)
//        let newPFBValue = try XCTUnwrap(pathBody.friction)
//        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
//        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
//    }
//
//    func testGetRestitution_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.restitution
//        let currPFBValue = pathBody.restitution
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetRestutution_setsBothValues() throws {
//        let currFSNValue = fiziksShapeNode.restitution
//        let currPFBValue = pathBody.restitution
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = CGFloat(1.3)
//        assert(newTestValue != currFSNValue)
//
//        pathBody.restitution = newTestValue
//        let newFSNValue = try XCTUnwrap(fiziksShapeNode.restitution)
//        let newPFBValue = try XCTUnwrap(pathBody.restitution)
//        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
//        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
//    }
//
//    func testGetLinearDamping_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.linearDamping
//        let currPFBValue = pathBody.linearDamping
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetLinearDamping_setsBothValues() throws {
//        let currFSNValue = fiziksShapeNode.linearDamping
//        let currPFBValue = pathBody.linearDamping
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = CGFloat(1.3)
//        assert(newTestValue != currFSNValue)
//
//        pathBody.linearDamping = newTestValue
//        let newFSNValue = try XCTUnwrap(fiziksShapeNode.linearDamping)
//        let newPFBValue = try XCTUnwrap(pathBody.linearDamping)
//        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
//        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
//    }
//
//    func testGetAngularDamping_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.angularDamping
//        let currPFBValue = pathBody.angularDamping
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetAngularDamping_setsBothValues() throws {
//        let currFSNValue = fiziksShapeNode.angularDamping
//        let currPFBValue = pathBody.angularDamping
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = CGFloat(1.3)
//        assert(newTestValue != currFSNValue)
//
//        pathBody.angularDamping = newTestValue
//        let newFSNValue = try XCTUnwrap(fiziksShapeNode.angularDamping)
//        let newPFBValue = try XCTUnwrap(pathBody.angularDamping)
//        XCTAssertEqual(newPFBValue, newTestValue, accuracy: 1e-4)
//        XCTAssertEqual(newFSNValue, newTestValue, accuracy: 1e-4)
//    }
//
//    func testGetCategoryBitMask_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.categoryBitMask
//        let currPFBValue = pathBody.categoryBitMask
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetCategoryBitMask_setsBothValues() {
//        let currFSNValue = fiziksShapeNode.categoryBitMask
//        let currPFBValue = pathBody.categoryBitMask
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = CategoryMask.max
//        assert(newTestValue != currFSNValue)
//
//        pathBody.categoryBitMask = newTestValue
//        let newFSNValue = fiziksShapeNode.categoryBitMask
//        let newPFBValue = pathBody.categoryBitMask
//        XCTAssertEqual(newPFBValue, newTestValue)
//        XCTAssertEqual(newFSNValue, newTestValue)
//    }
//
//    func testGetCollisionBitMask_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.collisionBitMask
//        let currPFBValue = pathBody.collisionBitMask
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetCollisionBitMask_setsBothValues() {
//        let currFSNValue = fiziksShapeNode.collisionBitMask
//        let currPFBValue = pathBody.collisionBitMask
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = CategoryMask.max
//        assert(newTestValue != currFSNValue)
//
//        pathBody.collisionBitMask = newTestValue
//        let newFSNValue = fiziksShapeNode.collisionBitMask
//        let newPFBValue = pathBody.collisionBitMask
//        XCTAssertEqual(newPFBValue, newTestValue)
//        XCTAssertEqual(newFSNValue, newTestValue)
//    }
//
//    func testGetContactTestBitMask_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.contactTestBitMask
//        let currPFBValue = pathBody.contactTestBitMask
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetContactTestBitMask_setsBothValues() {
//        let currFSNValue = fiziksShapeNode.contactTestBitMask
//        let currPFBValue = pathBody.contactTestBitMask
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = CategoryMask.max
//        assert(newTestValue != currFSNValue)
//
//        pathBody.contactTestBitMask = newTestValue
//        let newFSNValue = fiziksShapeNode.contactTestBitMask
//        let newPFBValue = pathBody.contactTestBitMask
//        XCTAssertEqual(newPFBValue, newTestValue)
//        XCTAssertEqual(newFSNValue, newTestValue)
//    }
//
//    func testGetUsesPreciseCollisionDetection_bothSameValue() {
//        let currFSNValue = fiziksShapeNode.usesPreciseCollisionDetection
//        let currPFBValue = pathBody.usesPreciseCollisionDetection
//        XCTAssertEqual(currFSNValue, currPFBValue)
//    }
//
//    func testSetUsesPreciseCollisionDetection_setsBothValues() {
//        let currFSNValue = fiziksShapeNode.usesPreciseCollisionDetection
//        let currPFBValue = pathBody.usesPreciseCollisionDetection
//        XCTAssertEqual(currFSNValue, currPFBValue)
//
//        let newTestValue = true
//        assert(newTestValue != currFSNValue)
//
//        pathBody.usesPreciseCollisionDetection = newTestValue
//        let newFSNValue = fiziksShapeNode.usesPreciseCollisionDetection
//        let newPFBValue = pathBody.usesPreciseCollisionDetection
//        XCTAssertEqual(newPFBValue, newTestValue)
//        XCTAssertEqual(newFSNValue, newTestValue)
//    }
//
//}
