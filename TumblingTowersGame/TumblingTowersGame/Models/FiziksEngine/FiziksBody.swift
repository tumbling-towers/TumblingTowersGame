/**
 Specifies a set of attributes that must be conformed to in order to be used by the `FiziksEngine`. 
 */

import Foundation

protocol FiziksBody: AnyObject {
    typealias BitMask = UInt32

    var fiziksShape: FiziksShape { get }
    var isDynamic: Bool { get set }
    var zRotation: CGFloat { get set }
    var position: CGPoint { get set }
    var categoryBitMask: BitMask { get }
    var collisionBitMask: BitMask { get }
    var contactTestBitMask: BitMask { get }
}
