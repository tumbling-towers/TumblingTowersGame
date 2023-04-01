//
//  GameEngineConstants.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 1/4/23.
//

import Foundation

struct GameEngineConstants {
    static let defaultSeed: Int = 1
    
    static let defaultBlockVelocity = CGVector(dx: 0, dy: -3)
    
    static let defaultPlatformBoundaryBuffer: Double = 200
    
    static let defaultPowerupHeightStep: Double = 50
    
    static let defaultInitialPowerupHeight: Double = 20
    
    static let defaultPowerupLineDimensions: CGSize = CGSize(width: 400, height: 5)
    
    static let defaultTriesToFindPlatformPosition: Int = 2
    
    static let bufferFromHighestPoint: Double = 50
    
    static let defaultPowerupPlatformWidth: Double = 20
    
    static let defaultPowerupPlatformHeight: Double = 20
}
