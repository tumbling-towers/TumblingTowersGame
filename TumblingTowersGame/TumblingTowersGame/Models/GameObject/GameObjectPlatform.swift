//
//  GameObjectPlatform.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation

struct GameObjectPlatform: GameObject {
    
    static let defaultWidth: Double = 500
    static let defaultHeight: Double = 100

    var id = UUID()
    var position: CGPoint
    var width: Double
    var height: Double
    var specialProperties: SpecialProperties

    init(id: UUID = UUID(),
         position: CGPoint,
         width: Double = GameObjectPlatform.defaultWidth,
         height: Double = GameObjectPlatform.defaultHeight,
         specialProperties: SpecialProperties = SpecialProperties()) {
        self.id = id
        self.position = position
        self.width = width
        self.height = height
        self.specialProperties = specialProperties
    }
}

extension GameObjectPlatform {
    static let samplePlatform = GameObjectPlatform(position: CGPoint(x: 500, y: 1_000))
}
