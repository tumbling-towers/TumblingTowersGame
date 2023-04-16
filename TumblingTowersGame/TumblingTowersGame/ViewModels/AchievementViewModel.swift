//
//  AchievementViewModel.swift
//  TumblingTowersGame
//
//  Created by Elvis on 16/4/23.
//

import Foundation

class AchievementViewModel: ObservableObject {

    @Published var toDisplayAchievements: [DisplayableAchievement] = []

    let storage: StorageManager

    init(storage: StorageManager) {
        self.storage = storage
        updateAchievements()
    }

    func updateAchievements() {
        let statsSystem = StatsTrackingSystem(eventManager: TumblingTowersEventManager(), storageManager: storage)
        let achievementSystem = AchievementSystem(eventManager: TumblingTowersEventManager(),
                                                  dataSource: statsSystem,
                                                  storageManager: storage)

        let updatedAchievements = achievementSystem.calculateAndGetUpdatedAchievements()

        let displayableAchievements = convertToRenderableAchievement(achievements: updatedAchievements)

        toDisplayAchievements = displayableAchievements
    }

    private func convertToRenderableAchievement(achievements: [any Achievement]) -> [DisplayableAchievement] {
        var displayableAchievements = [DisplayableAchievement]()
        for achievement in achievements {
            let displayableAchievement = DisplayableAchievement(id: UUID(),
                                                                name: achievement.name,
                                                                description: achievement.description,
                                                                goal: achievement.goal,
                                                                achieved: achievement.achieved)
            displayableAchievements.append(displayableAchievement)
        }
        return displayableAchievements
    }
}
