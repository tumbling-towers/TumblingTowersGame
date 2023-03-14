/**
 Conform to this protocol to create a `FiziksShape` and insert it into a  `FiziksBody`.
 This allows the `FiziksEngine` to represent any shape whose shape representation is a `CGPath`.
 */

import CoreGraphics
import Foundation
import SpriteKit

protocol PathFiziksShape: FiziksShape {
    var path: CGPath { get }
}

extension PathFiziksShape {
    var skShapeNode: SKShapeNode {
        SKShapeNode(path: path)
    }

    var skPhysicsBody: SKPhysicsBody {
        SKPhysicsBody(polygonFrom: path)
    }
}
