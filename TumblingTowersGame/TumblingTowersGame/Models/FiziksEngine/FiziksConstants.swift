//
//  FiziksConstants.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 16/3/23.
//

import Foundation

struct FiziksConstants {
    static let defaultPosition: CGPoint = .zero

    static let defaultVelocity: CGVector = .zero
    static let defaultAngularVelocity: CGFloat = .zero
    static let defaultIsResting = true
    static let defaultZRotation: Double = .zero

    static let defaultAffectedByGravity = true
    static let defaultAllowsRotation = true
    static let defaultIsDynamic = true

    static let defaultMass: CGFloat = 1
    static let defaultDensity: CGFloat = 1
    static let defaultFriction: CGFloat = 1.0
    static let defaultRestitution: CGFloat = 0.3
    static let defaultLinearDamping: CGFloat = 0.3
    static let defaultAngularDamping: CGFloat = 0.3

    static let defaultCategoryBitMask: BitMask = 0
    static let defaultCollisionBitMask: BitMask = 0
    static let defaultContactTestBitMask: BitMask = 0
    static let defaultUsesPreciseCollisionDetection = false
}
