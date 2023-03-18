//
//  GameObjectBlock.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation

struct GameObjectBlock: GameObject {
//    static var collisionBitmask: BitMask = ContactTestMask.block
//
//    static var contactTestBitmask: BitMask = ContactTestMask.block
//
//    static let categoryBitmask: BitMask = CategoryMask.block
    
    var id = UUID()
    var position: CGPoint
    var blockShape: BlockShapeEnum
    
    init(position: CGPoint, blockShape: BlockShapeEnum) {
        self.position = position
        self.blockShape = blockShape
    }
}

extension GameObjectBlock: Equatable {
    static func == (lhs: GameObjectBlock, rhs: GameObjectBlock) -> Bool {
        lhs.position == rhs.position && lhs.blockShape == rhs.blockShape
    }
}

extension GameObjectBlock {
    static let sampleBlock = GameObjectBlock(position: CGPoint(x: 500, y: 500), blockShape: .I)
}

