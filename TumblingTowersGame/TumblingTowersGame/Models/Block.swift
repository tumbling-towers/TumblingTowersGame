//
//  Block.swift
//  Facade
//
//  Created by Quan Teng Foong on 11/3/23.
//

import Foundation

class Block: GameObject {
    let fiziksShape: FiziksShape
    var position: CGPoint
    var zRotation: CGFloat
    let category: GameObjectCategory
    var isDynamic: Bool

    init(fiziksShape: FiziksShape,
         position: CGPoint,
         zRotation: CGFloat = 0,
         category: GameObjectCategory = .block,
         isDynamic: Bool = true) {
        self.fiziksShape = fiziksShape
        self.position = position
        self.zRotation = zRotation
        self.category = category
        self.isDynamic = isDynamic
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
