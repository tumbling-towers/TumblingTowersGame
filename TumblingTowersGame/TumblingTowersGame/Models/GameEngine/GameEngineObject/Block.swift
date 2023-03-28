//
//  Block.swift
//  Facade
//
//  Created by Quan Teng Foong on 11/3/23.
//

import CoreGraphics
import Foundation

class Block: GameEngineObject {
    let fiziksBody: FiziksBody
    
    let shape: ObjectShape
    
    var rotation: Double {
        fiziksBody.zRotation
    }

    static var collisionBitmask: BitMask = CollisionMask.block
    
    static var fallingCollisionBitmask: BitMask = CollisionMask.fallingBlock

    static var contactTestBitmask: BitMask = ContactTestMask.block
    
    static var fallingContactTestBitMask: BitMask = ContactTestMask.fallingBlock

    static let categoryBitmask: BitMask = CategoryMask.block

    init(fiziksBody: FiziksBody, shape: ObjectShape) {
        self.fiziksBody = fiziksBody
        self.shape = shape
    }
}

extension Block: Equatable {
    static func == (lhs: Block, rhs: Block) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension Block: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
