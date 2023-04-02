//
//  PathFiizksBodyTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import Foundation
import CoreGraphics
import XCTest

class PathFiziksBodyTests: XCTest {
    typealias P = CGPoint

    var pathBody: PathFiziksBody?
    static let points: [P] = [P(x: 0, y: 0),
                             P(x: 10, y: 0),
                             P(x: 10, y: 10),
                             P(x: 30, y: 10),
                             P(x: 30, y: 20),
                             P(x: 0, y: 20)]
    let path = CGPath.create(from: PathFiziksBodyTests.points)

    override func setUp() {
        pathBody = PathFiziksBody(path: path, position: .zero, zRotation: 5, categoryBitMask: 0x1, collisionBitMask: 0x1, contactTestBitMask: 0x1, isDynamic: true)
    }

    func test_createSkShapeNode() {
        let node = pathBody?.createSKShapeNode()
        guard let nodePath = pathBody?.path else {
            return XCTFail()
        }

        XCTAssertEqual(nodePath, path)
    }

    func test_createPhysicsBody() {
        let body = pathBody?.createSKPhysicsBody()
        guard let body = body else {
            return XCTFail()
        }

        XCTAssertTrue(body.isDynamic)
        XCTAssertEqual(body.categoryBitMask, 0x1)
        XCTAssertEqual(body.collisionBitMask, 0x1)
        XCTAssertEqual(body.contactTestBitMask, 0x1)
        XCTAssertEqual(body.node?.zRotation, 5)
        XCTAssertEqual(body.node?.position, .zero)
    }
}
