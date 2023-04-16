//
//  FiziksScene.swift
//  Facade
//
//  Created by Quan Teng Foong on 18/3/23.
//

import Foundation
import SpriteKit

public class FiziksScene: SKScene {

    public var gravity: CGVector {
        get {
            physicsWorld.gravity
        }
        set {
            physicsWorld.gravity = newValue
        }
    }

    public func addChild(_ fiziksBody: FiziksBody) {
        super.addChild(fiziksBody.fiziksShapeNode)
    }

    public func remove(_ fiziksBody: FiziksBody) {
        fiziksBody.fiziksShapeNode.removeFromParent()
    }

    public func pause() {
        physicsWorld.speed = .zero
    }

    public func unpause() {
        physicsWorld.speed = 1.0
    }
}
