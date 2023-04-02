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
}
