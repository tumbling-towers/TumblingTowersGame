//
//  GameObject.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation

protocol GameObject {
    static var categoryBitmask: BitMask { get }

    static var collisionBitmask: BitMask { get }

    static var contactTestBitmask: BitMask { get }
    
    var position: CGPoint { get set }
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
