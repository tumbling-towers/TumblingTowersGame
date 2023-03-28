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

    enum GameModes {
        case raceClock
        case survival
    }
}
