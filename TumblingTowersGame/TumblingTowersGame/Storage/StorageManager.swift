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

    /// Get file URL from specified file name.
    private func getFileURL(from name: String) throws -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent(name).appendingPathExtension(".data")
    }

    func saveSettings(_ settings: [Float]) throws {
        let data = try JSONEncoder().encode(settings)
        let outfile = try getFileURL(from: StorageManager.settingsFileName)
        try data.write(to: outfile)
    }

    func loadSettings() throws -> [Float] {
       let fileURL = try getFileURL(from: StorageManager.settingsFileName)
       guard let file = try? FileHandle(forReadingFrom: fileURL) else {
           return []
       }
        let settings = try JSONDecoder().decode([Float].self, from: file.availableData)
       return settings
   }
    
    
    
    func saveAchievements(_ achievements: [Achievement]) throws {
        var achievementsStorage: [AchievementStorage] = []
        for achievement in achievements {
            achievementsStorage.append(AchievementStorage(achievement))
        }
        
        let data = try JSONEncoder().encode(achievementsStorage)
        let outfile = try getFileURL(from: StorageManager.achievementsFileName)
        try data.write(to: outfile)
    }

    func loadAchievements() throws -> [AchievementStorage] {
       let fileURL = try getFileURL(from: StorageManager.achievementsFileName)
       guard let file = try? FileHandle(forReadingFrom: fileURL) else {
           return []
       }
        let achievements = try JSONDecoder().decode([AchievementStorage].self, from: file.availableData)
       return achievements
   }
    
    
    
    func saveStats(_ statTrackers: [StatTracker]) throws {
        var statsStorage: [StatStorage] = []
        for statTracker in statTrackers {
            print("converting \(StatStorage(statTracker))")
            statsStorage.append(StatStorage(statTracker))
        }
        
        let data = try JSONEncoder().encode(statsStorage)
        let outfile = try getFileURL(from: StorageManager.statsFileName)
        try data.write(to: outfile)
        print("-------")
        print("saving stats \(statsStorage)")
    }

    func loadStats() throws -> [StatStorage] {
        do {
            let fileURL = try getFileURL(from: StorageManager.statsFileName)
            guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                return []
            }
            do {
                let stats = try JSONDecoder().decode([StatStorage].self, from: file.availableData)
                
                print("loaded file \(file)")
                print("loaded stats \(stats)")
                return stats
            } catch {
                print("fail to decocde load")
            }
        } catch {
            print("fail to get file load")
        }
        
        return []
   }
    
}
