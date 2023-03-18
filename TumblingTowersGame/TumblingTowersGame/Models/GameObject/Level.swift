//
//  Level.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import Foundation

struct Level {
    var blocks: [GameObjectBlock]
    var platform: GameObjectPlatform
    
    mutating func move(block: GameObjectBlock, to: CGPoint) {
        for i in 0..<blocks.count where blocks[i] == block {
            blocks[i].move(to: to)
        }
    }
}


extension Level {
    static let sampleLevel = Level(blocks: [GameObjectBlock.sampleBlock], platform: GameObjectPlatform.samplePlatform)
}
