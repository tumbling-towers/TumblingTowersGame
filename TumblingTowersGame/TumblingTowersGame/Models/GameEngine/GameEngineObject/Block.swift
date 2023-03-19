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

    static var collisionBitmask: BitMask = ContactTestMask.block

    static var contactTestBitmask: BitMask = ContactTestMask.block

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
