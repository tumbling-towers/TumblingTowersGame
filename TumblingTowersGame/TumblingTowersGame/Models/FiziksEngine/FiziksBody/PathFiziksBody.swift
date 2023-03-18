/**
 A `FiziksBody` which has a shape represented using a `CGPath`.
 */

import CoreGraphics
import Foundation
import SpriteKit

class PathFiziksBody: FiziksBody {

    /// Shape representation for a `PathFiziksBody`
    var path: CGPath

    var position: CGPoint
    var zRotation: CGFloat
    let categoryBitMask: BitMask
    let collisionBitMask: BitMask
    let contactTestBitMask: BitMask
    var isDynamic: Bool
    var friction: Double

    init(path: CGPath,
         position: CGPoint,
         zRotation: CGFloat,
         categoryBitMask: BitMask,
         collisionBitMask: BitMask,
         contactTestBitMask: BitMask,
         isDynamic: Bool,
         friction: Double = FiziksConstants.defaultFriction) {
        self.path = path
        self.position = position
        self.zRotation = zRotation
        self.categoryBitMask = categoryBitMask
        self.collisionBitMask = collisionBitMask
        self.contactTestBitMask = contactTestBitMask
        self.isDynamic = isDynamic
        self.friction = friction
    }

    func createSKShapeNode() -> SKShapeNode {
        SKShapeNode(path: path)
    }

    func createSKPhysicsBody() -> SKPhysicsBody {
        SKPhysicsBody(polygonFrom: path)
    }
}

extension PathFiziksBody: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(position)"
    }
}
