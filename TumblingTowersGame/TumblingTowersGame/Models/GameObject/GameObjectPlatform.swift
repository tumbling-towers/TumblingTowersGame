//
//  GameObjectPlatform.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation

struct GameObjectPlatform: GameObject {
    var id = UUID()
    var position: CGPoint
}

extension GameObjectPlatform {
    static let samplePlatform = GameObjectPlatform(position: CGPoint(x: 500, y: 1000))
}
