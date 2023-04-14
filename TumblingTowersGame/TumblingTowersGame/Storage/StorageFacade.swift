//
//  StorageFacade.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 9/4/23.
//

import Foundation

struct StorageFacade {
    /// Get file URL from specified file name.
    private func getFileURL(from name: String) throws -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent(name).appendingPathExtension(".data")
    }
    
    func save(floats: [Float], fileName: String) throws {
        let data = try JSONEncoder().encode(floats)
        let outfile = try getFileURL(from: fileName)
        try data.write(to: outfile)
    }
    
    func loadFloats(fileName: String) throws -> [Float] {
       let fileURL = try getFileURL(from: fileName)
       guard let file = try? FileHandle(forReadingFrom: fileURL) else {
           return []
       }
       
        let floats = try JSONDecoder().decode([Float].self, from: file.availableData)
       return floats
   }
    
    func save(achievements: [AchievementStorage], fileName: String) throws {
        let data = try JSONEncoder().encode(achievements)
        let outfile = try getFileURL(from: fileName)
        try data.write(to: outfile)
    }
    
    func loadAchievements(fileName: String) throws -> [AchievementStorage] {
       let fileURL = try getFileURL(from: fileName)
       guard let file = try? FileHandle(forReadingFrom: fileURL) else {
           return []
       }
       
        let achievementStorages = try JSONDecoder().decode([AchievementStorage].self, from: file.availableData)
        return achievementStorages
    }

    func deleteAchievements(fileName: String) throws {
        let fileURL = try getFileURL(from: fileName)

        let fileManager = FileManager.default
        try fileManager.removeItem(at: fileURL)
    }
    
    func save(statStorages: [StatStorage], fileName: String) throws {
        let data = try JSONEncoder().encode(statStorages)
        let outfile = try getFileURL(from: fileName)
        try data.write(to: outfile)
        print("save stats facade")

    }
    
    func loadStatStorages(fileName: String) throws -> [StatStorage] {
       let fileURL = try getFileURL(from: fileName)
       guard let file = try? FileHandle(forReadingFrom: fileURL) else {
           return []
       }
       
        let statStorages = try JSONDecoder().decode([StatStorage].self, from: file.availableData)
        print("load stats facade")
       return statStorages
   }
}
