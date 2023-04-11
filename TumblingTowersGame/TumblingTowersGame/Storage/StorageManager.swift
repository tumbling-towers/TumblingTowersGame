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
    
    let storageFacade = StorageFacade()
    
    func saveSettings(_ settings: [Float]) throws {
        try storageFacade.save(floats: settings, fileName: StorageManager.settingsFileName)
    }
    
    func loadSettings() throws -> [Float] {
        let settings = try storageFacade.loadFloats(fileName: StorageManager.settingsFileName)
        return settings
    }
    
    func saveAchievements(_ achievements: [any Achievement]) throws {
        var achievementsStorage: [AchievementStorage] = []
        for achievement in achievements {
            achievementsStorage.append(AchievementStorage(achievement))
        }
        
        try storageFacade.save(achievements: achievementsStorage, fileName: StorageManager.achievementsFileName)
    }
    
    func loadAchievements() throws -> [AchievementStorage] {
        let achievementStorages = try storageFacade.loadAchievements(fileName: StorageManager.achievementsFileName)
        return achievementStorages
    }
    
    func saveStats(_ statTrackers: [StatTracker]) throws {
        var statsStorage: [StatStorage] = []
        for statTracker in statTrackers {
            statsStorage.append(StatStorage(statTracker))
        }
        
        try storageFacade.save(statStorages: statsStorage, fileName: StorageManager.statsFileName)
    }
    
    func loadStats() throws -> [StatStorage] {
        let statStorages = try storageFacade.loadStatStorages(fileName: StorageManager.statsFileName)
        return statStorages
    }
}
