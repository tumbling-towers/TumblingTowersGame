//
//  GameObjectBlock.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation

class GameObjectBlock: GameObject {
    static var collisionBitmask: BitMask = ContactTestMask.block

    static var contactTestBitmask: BitMask = ContactTestMask.block

    static let categoryBitmask: BitMask = CategoryMask.block
    
    var position: CGPoint
    var blockShape: BlockShapeEnum
    
    init(position: CGPoint, blockShape: BlockShapeEnum) {
        self.position = position
        self.blockShape = blockShape
    }
}
