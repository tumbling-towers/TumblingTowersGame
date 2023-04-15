//
//  AchievementsView.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 10/4/23.
//

import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @EnvironmentObject var gameEngineMgr: GameEngineManager

    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Singleplayer Achievements")
                    .modifier(CategoryText())
                ForEach($gameEngineMgr.achievements) { achievment in
                    VStack {
                        HStack {
                            Text(achievment.wrappedValue.name)
                                .modifier(CategoryText(fontSize: 18))
                            Spacer()
                            let image = achievment.wrappedValue.achieved
                                        ? ViewImageManager.tickImage
                                        : ViewImageManager.crossImage
                            Image(image)
                                .resizable()
                                .frame(
                                    width: 20,
                                    height: 20,
                                    alignment: .center)
                        }.frame(width: 2/3 * gameEngineMgr.levelDimensions.width)
                        HStack {
                            Text(achievment.wrappedValue.description)
                                .modifier(BodyText())
                            Spacer()
                        }
                    }.frame(width: 2/3 * gameEngineMgr.levelDimensions.width)
                }
                
                NormalGoBackButtonView(currGameScreen: $currGameScreen)

            }
        }
        .ignoresSafeArea(.all)
        .onAppear {
        }

    }

    // FIXME: Should get from adapter instead (Just move code into adapter)
    private func getUpdatedAchievements() -> [DisplayableAchievement] {

        let storage = mainGameMgr.storageManager
        let statsSystem = StatsTrackingSystem(eventManager: TumblingTowersEventManager(), storageManager: storage)
        let achievementSystem = AchievementSystem(eventManager: TumblingTowersEventManager(), dataSource: statsSystem, storageManager: storage)

        let achievements = achievementSystem.calculateAndGetUpdatedAchievements()

        let displayableAchievements = convertToRenderableAchievement(achievements: achievements)

        return displayableAchievements
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

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView(currGameScreen: .constant(.achievements))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: StorageManager()))
    }
}
