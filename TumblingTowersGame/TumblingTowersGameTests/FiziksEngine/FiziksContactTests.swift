//
//  FiziksContactTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import XCTest

final class FiziksContactTests: XCTestCase {
    func testConstruct() {
        let contact = FiziksContact(bodyA: MockFiziksBody(), bodyB: MockFiziksBody(), contactPoint: .zero, collisionImpulse: .zero, contactNormal: .zero)

        XCTAssertNotNil(contact)
    }
}
