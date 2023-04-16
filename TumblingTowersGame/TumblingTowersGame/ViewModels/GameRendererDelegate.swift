//
//  GameRendererDelegate.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation

protocol GameRendererDelegate: AnyObject {

    func rerender()

    func updateViewVariables(referenceBoxToUpdate: CGRect,
                             powerupsToUpdate: [Powerup.Type?],
                             gameModeToUpdate: GameMode,
                             timeRemainingToUpdate: Int,
                             scoreToUpdate: Int,
                             gameEndedToUpdate: Bool,
                             gameEndMainMessageToUpdate: String,
                             gameEndSubMessageToUpdate: String)

    func renderCurrentFrame(gameObjects: [any GameWorldObject], powerUpLine: PowerupLine)

    func renderLevel(gameObjectBlocks: [GameObjectBlock],
                     gameObjectPlatforms: [GameObjectPlatform],
                     powerupLine: PowerupLine)

    func getCurrInput() -> InputData

}
