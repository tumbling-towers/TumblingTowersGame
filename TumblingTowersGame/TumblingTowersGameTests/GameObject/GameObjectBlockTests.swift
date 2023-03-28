//
//  GameObjectBlockTests.swift
//  TumblingTowersGameTests
//
//  Created by Lee Yong Ler on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class GameObjectBlockTests: XCTestCase {

    func test_init() {
        let block = GameObjectBlock(position: CGPoint(x: 200, y: 200), blockShape: .J)
    }

    func test_sameBlockEquals() {
        XCTAssertEqual(GameObjectBlock.sampleBlock, GameObjectBlock.sampleBlock)
    }
}
