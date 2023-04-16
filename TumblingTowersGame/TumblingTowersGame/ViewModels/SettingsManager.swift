//
//  SettingsManager.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class SettingsManager: ObservableObject {
    private var storageManager = StorageManager()

    @Published var backgroundMusicVolume: Float {
        // Cannot use get {} set {} because Property wrapper cannot be applied to a computed property
        didSet {
            SoundSystem.shared.changeBackgroundMusicVolume(backgroundMusicVolume)
            try? storageManager.saveSettings([backgroundMusicVolume, otherSoundVolume, overallVolume])
        }
    }

    @Published var otherSoundVolume: Float {
        didSet {
            SoundSystem.shared.changeSoundVolume(otherSoundVolume)
            try? storageManager.saveSettings([backgroundMusicVolume, otherSoundVolume, overallVolume])
        }
    }

    @Published var overallVolume: Float {
        didSet {
            SoundSystem.shared.changeOverallVolume(overallVolume)
            try? storageManager.saveSettings([backgroundMusicVolume, otherSoundVolume, overallVolume])
        }
    }

    init() {
        backgroundMusicVolume = SoundSystem.shared.backgroundMusicVolume
        otherSoundVolume = SoundSystem.shared.otherSoundVolume
        overallVolume = SoundSystem.shared.overallVolume

        loadSettings()
    }

    func loadSettings() {
        guard let settings = try? storageManager.loadSettings() else {
            return
        }

        guard settings.count > 0 else {
            return
        }
        backgroundMusicVolume = settings[0]
        otherSoundVolume = settings[1]
        overallVolume = settings[2]

        SoundSystem.shared.changeBackgroundMusicVolume(backgroundMusicVolume)
        SoundSystem.shared.changeSoundVolume(otherSoundVolume)
        SoundSystem.shared.changeOverallVolume(overallVolume)
    }

    func setStorageManager(storageManager: StorageManager) {
        self.storageManager = storageManager
    }

}
