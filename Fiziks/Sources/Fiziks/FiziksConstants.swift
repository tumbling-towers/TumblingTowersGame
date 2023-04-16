//
//  FiziksConstants.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 16/3/23.
//

import Foundation

public struct FiziksConstants {
    public static let defaultFiziksEngineGravity = CGVector(dx: 0, dy: -1.0)
    
    public static let defaultPosition: CGPoint = .zero

    public static let defaultVelocity: CGVector = .zero
    public static let defaultAngularVelocity: CGFloat = .zero
    public static let defaultIsResting = true
    public static let defaultZRotation: Double = .zero

    public static let defaultAffectedByGravity = true
    public static let defaultAllowsRotation = true
    public static let defaultIsDynamic = true

    public static let defaultMass: CGFloat = 1
    public static let defaultDensity: CGFloat = 1
    public static let defaultFriction: CGFloat = 1.0
    public static let defaultRestitution: CGFloat = 0.3
    public static let defaultLinearDamping: CGFloat = 0.3
    public static let defaultAngularDamping: CGFloat = 0.3

    public static let defaultCategoryBitMask: BitMask = 0
    public static let defaultCollisionBitMask: BitMask = 0
    public static let defaultContactTestBitMask: BitMask = 0
    public static let defaultUsesPreciseCollisionDetection = false
}
