//
//  Block.swift
//  Facade
//
//  Created by Quan Teng Foong on 11/3/23.
//

import Foundation

class Block: GameObject {
    let fiziksBody: FiziksBody

    static var collisionBitmask: BitMask = ContactTestMask.block

    static var contactTestBitmask: BitMask = ContactTestMask.block

    static let categoryBitmask: BitMask = CategoryMask.block

    init(fiziksBody: FiziksBody) {
        self.fiziksBody = fiziksBody
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
