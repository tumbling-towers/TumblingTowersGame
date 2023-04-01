//
//  MainMenuView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @EnvironmentObject var gameEngineMgr: GameEngineManager

    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Spacer()

                Text("Welcome to.....")
                Text("TUBMLING TOWERS")
                    .font(.system(size: 60, weight: .heavy))

                Spacer()

                Button {
                    currGameScreen = .gameModeSelection
                } label: {
                    Text("START GAME")
                        .modifier(MenuButtonText(fontSize: 30))
                }

                Button {
                    currGameScreen = .achievements
                } label: {
                    Text("ACHIEVEMENTS")
                        .modifier(MenuButtonText(fontSize: 30, padding: 50))
                }

                Button {
                    currGameScreen = .settings
                } label: {
                    Text("SETTINGS")
                        .modifier(MenuButtonText(fontSize: 30))
                }

                Spacer()
                Spacer()
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(currGameScreen: .constant(.mainMenu))
            .environmentObject(MainGameManager())
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}
