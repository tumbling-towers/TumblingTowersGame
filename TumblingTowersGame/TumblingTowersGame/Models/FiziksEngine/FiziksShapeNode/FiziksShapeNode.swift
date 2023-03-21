//
//  FiziksNode.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 21/3/23.
//

import Foundation
import SpriteKit

class FiziksShapeNode: SKShapeNode {
    weak var fiziksBody: FiziksBody?
    override var position: CGPoint {
        didSet {
            print("Didset \(position.x) ,  \(position.y)")
            if position != fiziksBody?.position {
                fiziksBody?.position = position
            }
        }
    }
    
    override var zRotation: CGFloat {
        didSet {
            if zRotation != fiziksBody?.zRotation {
                fiziksBody?.zRotation = zRotation
            }
        }
    }
}

extension FiziksShapeNode: FiziksBodyDelegate {
    func didUpdatePosition(to newPosition: CGPoint) {
        self.position = newPosition
    }
    
    func didUpdateRotation(to newRotation: Double) {
        self.zRotation = newRotation
    }
}


