/**
 Specifies a set of attributes that must be conformed to in order to be used by the `FiziksEngine`.
 */

import Foundation
import SpriteKit

protocol FiziksBody: AnyObject {
    var delegate: FiziksBodyDelegate? { get set }
    var position: CGPoint { get set }
    var zRotation: CGFloat { get set }
    var categoryBitMask: BitMask { get }
    var collisionBitMask: BitMask { get }
    var contactTestBitMask: BitMask { get }
    var isDynamic: Bool { get set }
    var friction: Double { get set }

    func createFiziksShapeNode() -> FiziksShapeNode
    func createSKPhysicsBody() -> SKPhysicsBody
}
