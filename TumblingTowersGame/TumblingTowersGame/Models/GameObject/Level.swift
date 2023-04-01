//
//  Level.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import Foundation

struct Level {
    var blocks: [GameObjectBlock]
    var platforms: [GameObjectPlatform]

    mutating func move(block: GameObjectBlock, to: CGPoint) {
        for i in 0..<blocks.count where blocks[i] == block {
            blocks[i].move(to: to)
        }
    }

    mutating func add(block: GameObjectBlock) {
        blocks.append(block)
    }

    mutating func add(platform: GameObjectPlatform) {
        platforms.append(platform)
    }
}

extension Level {
    static let sampleLevel = Level(blocks: [GameObjectBlock.sampleBlock], platforms: [GameObjectPlatform.samplePlatform])
}
