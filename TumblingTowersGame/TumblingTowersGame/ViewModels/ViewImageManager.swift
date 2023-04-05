//
//  ViewImageManager.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import Foundation

struct ViewImageManager {
    static let backgroundImage = "backgroundImage"
    static let platformImage = "platformImage"

    static let LBlockImage = "LBlockImage"
    static let IBlockImage = "IBlockImage"
    static let JBlockImage = "JBlockImage"
    static let OBlockImage = "OBlockImage"
    static let ZBlockImage = "ZBlockImage"
    static let TBlockImage = "TBlockImage"
    static let SBlockImage = "SBlockImage"

    static let powerUpLineImage = ""
    static let goalLineImage = ""

    static let GluePowerupImage = "glue"
    static let PlatformPowerupImage = "platform"

    static let blockShapeToImage: [TetrisType: String] = [
        .L: LBlockImage,
        .I: IBlockImage,
        .J: JBlockImage,
        .O: OBlockImage,
        .Z: ZBlockImage,
        .T: TBlockImage,
        .S: SBlockImage
    ]

    static let powerupToImage: [PowerupType: String] = [
        .glue: GluePowerupImage,
        .platform: PlatformPowerupImage
    ]
    
    static let pauseButton = "pause"
    static let resumeButton = "resume"
    static let exitButton = "exit"
    static let startButton = "start"
    static let achievementsButton = "achievements"
    static let settingsButton = "settings"
    
    static let mainLogo = "ttlogo"
}
