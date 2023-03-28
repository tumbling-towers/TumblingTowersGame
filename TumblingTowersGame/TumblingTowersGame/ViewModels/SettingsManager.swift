//
//  SettingsManager.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class SettingsManager: ObservableObject {
    @Published var backgroundMusicVolume: Float {
        didSet {
            SoundSystem.shared.changeBackgroundMusicVolume(backgroundMusicVolume)
        }
    }

    @Published var otherSoundVolume: Float {
        didSet {
            SoundSystem.shared.changeSoundVolume(otherSoundVolume)
        }
    }

    init() {
        backgroundMusicVolume = SoundSystem.shared.backgroundMusicVolume
        otherSoundVolume = SoundSystem.shared.otherSoundVolume
    }

}
