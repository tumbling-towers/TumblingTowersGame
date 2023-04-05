//
//  GameWorldConstants.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 1/4/23.
//

import Foundation

struct GameWorldConstants {
    static let defaultSeed: Int = 1

    static let defaultBlockVelocity = CGVector(dx: 0, dy: -3)

    static let defaultPlatformBoundaryBuffer: Double = 200

    static let defaultPowerupHeightStep: Double = 50

    static let defaultInitialPowerupHeight: Double = 200

    static let defaultPowerupLineDimensions = CGSize(width: 400, height: 5)
    
    static let defaultMainPlatformDimensions = CGSize(width: 200, height: 100)
    
    static let mainPlatformYPos = 100
    
    static let mainPlatformPoints = [CGPoint(x: 0, y: defaultMainPlatformDimensions.height),
                                     CGPoint(x: defaultMainPlatformDimensions.width,
                                             y: defaultMainPlatformDimensions.height),
                                     CGPoint(x: defaultMainPlatformDimensions.width, y: 0),
                                                  CGPoint(x: 0, y: 0)]

    static let defaultTriesToFindPlatformPosition: Int = 2

    static let bufferFromHighestPoint: Double = 50

    static let defaultPowerupPlatformWidth: Double = 20

    static let defaultPowerupPlatformHeight: Double = 20
    
    static let levelBoundaryWidth: Double = 5
}
