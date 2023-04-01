//
//  SettingsManager.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class SettingsManager: ObservableObject {
    @Published var backgroundMusicVolume: Float {
        // Cannot use get {} set {} because Property wrapper cannot be applied to a computed property
        didSet {
            SoundSystem.shared.changeBackgroundMusicVolume(backgroundMusicVolume)
        }
    }

    @Published var otherSoundVolume: Float {
        didSet {
            SoundSystem.shared.changeSoundVolume(otherSoundVolume)
        }
    }

    @Published var overallVolume: Float {
        didSet {
            SoundSystem.shared.changeOverallVolume(overallVolume)
        }
    }

    init() {
        backgroundMusicVolume = SoundSystem.shared.backgroundMusicVolume
        otherSoundVolume = SoundSystem.shared.otherSoundVolume
        overallVolume = SoundSystem.shared.overallVolume
    }

}
