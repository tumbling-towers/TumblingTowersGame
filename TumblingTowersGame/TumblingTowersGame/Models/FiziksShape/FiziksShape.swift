/**
 `FiziksShape` is used to describe the shape of a `FiziksBody`. Since `SKShapeNode`
 and `SKPhysicsBody` has different constructors that take in different shape repsentations,
 this abstraction is required to call a different constructor for a different shape.
 
 Currently only `PathFiziksShape` is implemented. To allow `FiziksEngine` to take in
 `FiziksBody`s of different shape represntations, create new prococols that conform to
 `FiziksShape` (e.g. `CircleFiziksShape`, `RectFiziksShape`).
 */

import Foundation
import SpriteKit

protocol FiziksShape {
    var skShapeNode: SKShapeNode { get }
    var skPhysicsBody: SKPhysicsBody { get }
}
