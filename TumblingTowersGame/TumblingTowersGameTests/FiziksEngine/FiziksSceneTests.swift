//
//  FiziksContactTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class FiziksSceneTests: XCTestCase {

    var fiziksScene: FiziksScene!

    override func setUp() {
        let testSize = CGSize(width: 100, height: 100)
        fiziksScene = FiziksScene(size: testSize)
    }

    func testAddChild_childAdded() {
        let testFiziksBody = MockFiziksBody()
        fiziksScene.addChild(testFiziksBody)
        XCTAssertTrue(fiziksScene.children.contains(testFiziksBody.fiziksShapeNode))
    }

    func testRemove_childRemoved() {
        let testFiziksBody = MockFiziksBody()
        fiziksScene.addChild(testFiziksBody)
        XCTAssertTrue(fiziksScene.children.contains(testFiziksBody.fiziksShapeNode))

        fiziksScene.remove(testFiziksBody)
        XCTAssertFalse(fiziksScene.children.contains(testFiziksBody.fiziksShapeNode))
    }
}
