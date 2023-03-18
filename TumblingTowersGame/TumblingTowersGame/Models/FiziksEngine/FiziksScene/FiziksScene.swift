//
//  FiziksScene.swift
//  Facade
//
//  Created by Quan Teng Foong on 18/3/23.
//

import Foundation
import SpriteKit

class FiziksScene: SKScene {

    weak var fiziksSceneUpdateDelegate: FiziksSceneUpdateDelegate?

    var gravity: CGVector {
        get {
            physicsWorld.gravity
        }
        set {
            physicsWorld.gravity = newValue
        }
    }

    init(size: CGSize, boundingRect: CGRect) {
        super.init(size: size)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: boundingRect)
    }

    required init?(coder aDecoder: NSCoder) {
        nil
    }

    override func didFinishUpdate() {
        fiziksSceneUpdateDelegate?.didUpdateFiziksScene()
    }
}
