//
//  Constants.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class Constants {
    static let backgroundMusicFileName = "bkgMusic.mp3"

    enum CurrGameScreens {
        case mainMenu
        case gameModeSelection
        case gameplay
        case settings
        case achievements
    }

    enum GameModeTypes: String {
        case SURVIVAL = "Survival"
        case RACECLOCK = "Race Against the Clock"
    }

    enum GameState {
        case WIN_SURVIVAL
        case LOSE_SURVIVAL
        case WIN_RACE
        case LOSE_RACE
        case RUNNING
        case PAUSED
    }

}
