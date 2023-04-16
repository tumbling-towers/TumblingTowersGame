//
//  GameObjectBlock.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation
import CoreGraphics

struct GameObjectBlock: GameObject {
    var id = UUID()

    var position: CGPoint

    /// Path of the GameObjectBlock before applying rotation.
    private var rawPath: CGPath

    /// Path of GameObjectBlock after applying rotation
    var path: CGPath {
        rawPath.rotate(by: rotation)
    }

    var height: Double {
        path.height
    }
    var width: Double {
        path.width
    }

    var rotation: Double

    var specialProperties: SpecialProperties

    init(position: CGPoint, path: CGPath, specialProperties: SpecialProperties, rotation: Double = 0) {
        self.position = position
        self.rawPath = path
        self.rotation = rotation
        self.specialProperties = specialProperties
    }
}

extension GameObjectBlock: Equatable {
    static func == (lhs: GameObjectBlock, rhs: GameObjectBlock) -> Bool {
        lhs.position == rhs.position && lhs.path == rhs.path
    }
}

extension GameObjectBlock {
    static let sampleBlock = GameObjectBlock(position: CGPoint(x: 500,
                                                               y: 500),
                                             path: TetrisShape(type: .I).path,
                                             specialProperties: SpecialProperties())
}
