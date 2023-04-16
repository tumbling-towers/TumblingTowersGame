/**
 Specifies a set of attributes that must be conformed to in order to be used by the `FiziksEngine`.
 */

import Foundation

public typealias BitMask = UInt32

public protocol FiziksBody: AnyObject {

    var fiziksShapeNode: FiziksShapeNode { get set }

    // MARK: Attributes of a physics body with respect to the world
    var position: CGPoint { get set }
    var zRotation: CGFloat { get set }
    var velocity: CGVector? { get set }
    var angularVelocity: CGFloat? { get set }
    var isResting: Bool? { get set }

    // MARK: Attributes defining how forces affect a physics body
    var affectedByGravity: Bool? { get set }
    var allowsRotation: Bool? { get set }
    var isDynamic: Bool? { get set }

    // MARK: Attributes defining a physics body's physical properties
    var mass: CGFloat? { get set }
    var density: CGFloat? { get set }
    var area: CGFloat? { get }
    var friction: CGFloat? { get set }
    var restitution: CGFloat? { get set }
    var linearDamping: CGFloat? { get set }
    var angularDamping: CGFloat? { get set }

    // MARK: Attributes for working with collisions and contacts
    var categoryBitMask: BitMask? { get set }
    var collisionBitMask: BitMask? { get set }
    var contactTestBitMask: BitMask? { get set }
    var usesPreciseCollisionDetection: Bool? { get set }

    // MARK: Methods to apply forces and impulses to a physics body
    func applyForce(_ force: CGVector)
    func applyTorque(_ torque: CGFloat)
    func applyForce(_ force: CGVector, at point: CGPoint)
    func applyImpulse(_ impulse: CGVector)
    func applyAngularImpulse(_ angularImpulse: CGFloat)
    func applyImpulse(_ impulse: CGVector, at point: CGPoint)
}
