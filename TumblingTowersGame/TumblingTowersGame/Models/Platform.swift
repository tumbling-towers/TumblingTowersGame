//
//  Platform.swift
//  Facade
//
//  Created by Quan Teng Foong on 11/3/23.
//

import Foundation

class Platform: GameObject {
    let fiziksShape: FiziksShape
    var position: CGPoint
    var zRotation: CGFloat
    let category: GameObjectCategory
    var isDynamic: Bool

    init(fiziksShape: FiziksShape,
         position: CGPoint,
         zRotation: CGFloat = 0,
         category: GameObjectCategory = .platform,
         isDynamic: Bool = false) {
        self.fiziksShape = fiziksShape
        self.position = position
        self.zRotation = zRotation
        self.category = category
        self.isDynamic = isDynamic
    }
}

extension Platform: Equatable {
    static func == (lhs: Platform, rhs: Platform) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension Platform: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
