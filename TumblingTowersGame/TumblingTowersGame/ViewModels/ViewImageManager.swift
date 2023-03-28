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

    static let blockShapeToImage: [TetrisType: String] = [
        .L: LBlockImage,
        .I: IBlockImage,
        .J: JBlockImage,
        .O: OBlockImage,
        .Z: ZBlockImage,
        .T: TBlockImage,
        .S: SBlockImage
    ]

    // TODO: should throw / remove
//    static func getBlockImage(_ block: GameObjectBlock) -> String? {
//        guard let image = blockShapeToImage[block.blockShape] else {
//            return ""
//        }
//        return image
//    }
    // TODO: vines blocks
}
