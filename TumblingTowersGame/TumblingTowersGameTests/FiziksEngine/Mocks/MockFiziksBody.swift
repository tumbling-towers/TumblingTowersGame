//
//  FiziksMocks.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import Foundation
import SpriteKit

class MockFiziksBody: FiziksBody {
    var categoryBitMask: BitMask
    
    var collisionBitMask: BitMask
    
    var contactTestBitMask: BitMask
    
    var position: CGPoint
    
    var zRotation: CGFloat
    
    var isDynamic: Bool
    
    var friction: Double
    
    static let defaultRect = CGRect(x: .zero, y: .zero, width: 1, height: 1)
    
    static let defaultSize = CGSize(width: 1, height: 1)
    
    
    init(categoryBitMask: BitMask = 0x1, collisionBitMask: BitMask = 0x1, contactTestBitMask: BitMask = 0x1, position: CGPoint = .zero, zRotation: CGFloat = .zero, isDynamic: Bool = true, friction: Double = 1.0) {
        self.categoryBitMask = categoryBitMask
        self.collisionBitMask = collisionBitMask
        self.contactTestBitMask = contactTestBitMask
        self.position = position
        self.zRotation = zRotation
        self.isDynamic = isDynamic
        self.friction = friction
    }
    
    func createSKShapeNode() -> SKShapeNode {
        SKShapeNode(rect: MockFiziksBody.defaultRect)
    }
    
    func createSKPhysicsBody() -> SKPhysicsBody {
        SKPhysicsBody(rectangleOf: MockFiziksBody.defaultSize)
    }
    
    
}
