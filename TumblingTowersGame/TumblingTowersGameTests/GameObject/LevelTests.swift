//
//  LevelTests.swift
//  TumblingTowersGameTests
//
//  Created by Lee Yong Ler on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class LevelTests: XCTestCase {

    func test_init() {
        let level = Level(blocks: [GameObjectBlock.sampleBlock], platform: GameObjectPlatform.samplePlatform)
    }

    func test_moveBlock() {
        var level = Level(blocks: [GameObjectBlock.sampleBlock], platform: GameObjectPlatform.samplePlatform)
        XCTAssertEqual(level.blocks.count, 1)

        level.move(block: GameObjectBlock.sampleBlock, to: CGPoint(x: 500, y: 500))
        XCTAssertEqual(level.blocks[0].position, CGPoint(x: 500, y: 500))
    }

}
