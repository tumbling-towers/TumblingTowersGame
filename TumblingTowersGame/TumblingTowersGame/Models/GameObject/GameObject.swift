//
//  GameObject.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation

protocol GameObject: Identifiable {
    var position: CGPoint { get set }

    var height: Double { get }

    var width: Double { get }
    
    var specialProperties: SpecialProperties { get }
}

extension GameObject {
    mutating func move(to newPosition: CGPoint) {
        position = newPosition
    }

    mutating func move(by displacement: CGVector) {
        let newPosition = CGPoint(x: position.x + displacement.dx, y: position.y + displacement.dy)
        move(to: newPosition)
    }
}
