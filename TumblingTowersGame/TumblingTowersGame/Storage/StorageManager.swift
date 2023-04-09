//
//  StorageManager.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 2/4/23.
//

import Foundation

class StorageManager {
    static let settingsFileName = "settings"
    static let achievementsFileName = "achievements"
    static let statsFileName = "stats"
    static let storageFacade = StorageFacade()


    func saveSettings(_ settings: [Float]) throws {
        try StorageManager.storageFacade.save(floats: settings, fileName: StorageManager.settingsFileName)
    }

    func loadSettings() throws -> [Float] {
        let settings = try StorageManager.storageFacade.loadFloats(fileName: StorageManager.settingsFileName)
       return settings
   }
    
    
    func saveAchievements(_ achievements: [Achievement]) throws {
        var achievementsStorage: [AchievementStorage] = []
        for achievement in achievements {
            achievementsStorage.append(AchievementStorage(achievement))
        }
        
        try StorageManager.storageFacade.save(achievements: achievementsStorage, fileName: StorageManager.achievementsFileName)
    }

    func loadAchievements() throws -> [AchievementStorage] {
        let achievementStorages = try StorageManager.storageFacade.loadAchievements(fileName: StorageManager.achievementsFileName)
       return achievementStorages
   }
    
    
    
    func saveStats(_ statTrackers: [StatTracker]) throws {
        var statsStorage: [StatStorage] = []
        for statTracker in statTrackers {
            statsStorage.append(StatStorage(statTracker))
        }
        
        try StorageManager.storageFacade.save(statStorages: statsStorage, fileName: StorageManager.statsFileName)
        print("save stats manager")
    }

    func loadStats() throws -> [StatStorage] {
        let statStorages = try StorageManager.storageFacade.loadStatStorages(fileName: StorageManager.statsFileName)
        print("load stats manager")
       return statStorages
    
   }
    
}
