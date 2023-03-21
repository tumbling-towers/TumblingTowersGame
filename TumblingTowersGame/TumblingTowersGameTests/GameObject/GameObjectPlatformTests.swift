//
//  GameObjectPlatformTests.swift
//  TumblingTowersGameTests
//
//  Created by Lee Yong Ler on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class GameObjectPlatformTests: XCTestCase {
    
    func test_init() {
        let platform = GameObjectPlatform(position: CGPoint(x: 200, y: 1000))
    }
}
