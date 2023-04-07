//
//  Constants.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class Constants {
    static let backgroundMusicFileName = "bkgMusic.mp3"
    
    static let tapInputDescription =
"""
Swipe left/right: move the block in that direction.
Swipe down: speed up the downward movement of the block.\n
""" + generalInputDescription
    
    static let gyroInputDescription =
"""
Tilt left/right: move the block in that direction.
Swipe down: speed up the downward movement of the block.\n
""" + generalInputDescription
    
    static let generalInputDescription =
"""
Powerup button: activate the currently available powerup.
Rotate button: rotate the block clockwise.
"""

    static let defaultWinMainString = "Congratulations..."

    static let defaultLoseMainString = "You LOST!!!"

    enum CurrGameScreens {
        case mainMenu
        case gameModeSelection
        case gameplay
        case settings
        case achievements
    }

    static let gameModeTypeToClass: [String: GameMode.Type] = [GameModeTypes.SURVIVAL.rawValue: SurvivalGameMode.self,
                                                               GameModeTypes.RACECLOCK.rawValue: RaceTimeGameMode.self,
                                                               GameModeTypes.SANDBOX.rawValue: SandboxGameMode.self]

    enum GameModeTypes: String {
        case SURVIVAL = "Survival"
        case RACECLOCK = "Race Against the Clock"
        case SANDBOX = "Sandbox"
    }

    static func getGameModeType(from: GameModeTypes) -> GameMode.Type? {
        gameModeTypeToClass[from.rawValue]
    }

    enum GameState {
        case WIN
        case LOSE
        case RUNNING
        case PAUSED
        case NONE
    }

    static let gameInputTypeToClass: [String: InputSystem.Type] = [GameInputTypes.TAP.rawValue: TapInput.self,
                                                                   GameInputTypes.GYRO.rawValue: GyroInput.self]

    enum GameInputTypes: String, Equatable, CaseIterable {
        case TAP = "Tap"
        case GYRO = "Gyro"
    }
    
    static let gameInputTypeToDescription: [String: String] = [GameInputTypes.TAP.rawValue: Constants.tapInputDescription,
                                                               GameInputTypes.GYRO.rawValue: Constants.gyroInputDescription]

    static func getGameInputType(fromGameInputType: GameInputTypes) -> InputSystem.Type? {
        gameInputTypeToClass[fromGameInputType.rawValue]
    }

}
