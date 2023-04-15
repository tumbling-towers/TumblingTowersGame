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

    mutating func move(block: GameObjectBlock, to newPoint: CGPoint) {
        for idx in 0..<blocks.count where blocks[idx] == block {
            blocks[idx].move(to: newPoint)
        }
    }

    mutating func add(block: GameObjectBlock) {
        blocks.append(block)
    }

    mutating func add(platform: GameObjectPlatform) {
        platforms.append(platform)
    }
}
