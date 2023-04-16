//
//  FiziksContactTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import XCTest
@testable import Fiziks

final class FiziksContactTests: XCTestCase {

    static let points: [CGPoint] = [CGPoint(x: 0, y: 0),
                                    CGPoint(x: 10, y: 0),
                                    CGPoint(x: 10, y: 10),
                                    CGPoint(x: 30, y: 10),
                                    CGPoint(x: 30, y: 20),
                                    CGPoint(x: 0, y: 20)]
    let path = CGPath.create(from: FiziksContactTests.points)

    func testConstruct() {
        let contact = FiziksContact(bodyA: MockFiziksBody(),
                                    bodyB: MockFiziksBody(),
                                    contactPoint: .zero,
                                    collisionImpulse: .zero,
                                    contactNormal: .zero)

        XCTAssertNotNil(contact)
    }
}
