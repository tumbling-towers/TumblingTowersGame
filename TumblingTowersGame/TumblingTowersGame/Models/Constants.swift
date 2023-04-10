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
Powerup Button: Activates the chosen powerup.
Rotate Button: Rotates the block clockwise.
Pause Button: Pauses the game.
"""

    static let defaultWinMainString = "Congratulations..."

    static let defaultLoseMainString = "You LOST!!!"

    static let instructionsTitle = "Welcome to Tumbling Towers!"
    static let instructionsPressStart = "Press Start to begin the game!"
    static let instructionsGameModes = "First, we need to choose a game mode. Choose from:"
    static let instructionsAfterSelectGameMode = "After you select a game mode, the game starts!"
    static let instructionsInputControl = "Now a new tetris shaped block gets inserted into the game. You can control it using your chosen input method in Settings. Input Methods includes: "
    static let instructionsBlockContact = "When the currently moving block hits a platform or another block, you will lose control of that block. A new block would be inserted at the top of the screen and you can control it. Build up to the powerup line to gain powerups! (Only when your tower is stable!!)"
    static let instructionsOtherGuiButtons = "There are other buttons available on the screen for you to press."

    static let instructionsStackBlocks = "Why continue reading blocks of text? Start up the game instead, stack the blocks as high as you can... and..."
    static let instructionsHaveFun = "HAVE FUN!!!"

    static let instructionsDefaultGamemodeText = "A Tumbling Towers Game Mode."
    static let instructionsDefaultInputText = "A Tumbling Towers Input Method"


    enum CurrGameScreens {
        case mainMenu
        case playerOptionSelection
        case gameModeSelection
        case singleplayerGameplay
        case multiplayerGameplay
        case settings
        case tutorial
        case achievements
    }

    static let gameModeTypeToClass: [String: GameMode.Type] = [GameModeTypes.SURVIVAL.rawValue: SurvivalGameMode.self,
                                                               GameModeTypes.RACECLOCK.rawValue: RaceTimeGameMode.self,
                                                               GameModeTypes.SANDBOX.rawValue: SandboxGameMode.self]

    enum GameModeTypes: String, Equatable, CaseIterable {
        case SURVIVAL = "Survival"
        case RACECLOCK = "Race the Clock"
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
