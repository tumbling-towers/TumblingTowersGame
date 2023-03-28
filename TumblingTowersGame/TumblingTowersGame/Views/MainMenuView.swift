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
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .bold))
                }

                Button {
                    currGameScreen = .achievements
                } label: {
                    Text("ACHIEVEMENTS")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .bold))
                }
                .padding(.all, 50)

                Button {
                    currGameScreen = .settings
                } label: {
                    Text("SETTINGS")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .bold))
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
