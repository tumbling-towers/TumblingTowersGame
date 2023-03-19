//
//  GameRendererDelegate.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation

protocol GameRendererDelegate: AnyObject {

    func rerender()

    func renderLevel(level: Level, gameObjectBlocks: [GameObjectBlock], gameObjectPlatform: GameObjectPlatform)

    func getCurrInput() -> InputType

}
