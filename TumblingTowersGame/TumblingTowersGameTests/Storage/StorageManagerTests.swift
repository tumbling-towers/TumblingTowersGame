//
//  StorageManagerTests.swift
//  TumblingTowersGameTests
//
//  Created by Lee Yong Ler on 2/4/23.
//

import Foundation
import XCTest
@testable import TumblingTowersGame

final class StorageManagerTests: XCTestCase {
    func testConstuct() {
        let storageManager = StorageManager()
    }

    func testSaveSettings() {
        let storageManager = StorageManager()
        try? storageManager.saveSettings([0.1, 0.2, 0.3])
    }

    func testSaveAndLoadSettings() {
        let storageManager = StorageManager()
        let settingsToSave: [Float] = [0.1, 0.2, 0.3]
        try? storageManager.saveSettings(settingsToSave)
        let settings = try? storageManager.loadSettings()
        XCTAssertEqual(settings, settingsToSave)
    }
}
