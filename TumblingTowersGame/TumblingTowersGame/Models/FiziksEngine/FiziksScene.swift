//
//  FiziksScene.swift
//  Facade
//
//  Created by Quan Teng Foong on 18/3/23.
//

import Foundation
import SpriteKit

class FiziksScene: SKScene {

    var gravity: CGVector {
        get {
            physicsWorld.gravity
        }
        set {
            physicsWorld.gravity = newValue
        }
    }

    func addChild(_ fiziksBody: FiziksBody) {
        super.addChild(fiziksBody.fiziksShapeNode)
    }

    func remove(_ fiziksBody: FiziksBody) {
        fiziksBody.fiziksShapeNode.removeFromParent()
    }
    
    func pause() {
        physicsWorld.speed = .zero
    }
    
    func unpause() {
        physicsWorld.speed = 1.0
    }
}
