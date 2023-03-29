//
//  ContentView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 14/3/23.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var mainGameMgr: MainGameManager
    @StateObject var gameEngineMgr: GameEngineManager

    @State var currGameScreen = Constants.CurrGameScreens.mainMenu

    var body: some View {

        if currGameScreen == .mainMenu {
            MainMenuView(currGameScreen: $currGameScreen)
                .environmentObject(mainGameMgr)
                .environmentObject(gameEngineMgr)
        } else if currGameScreen == .gameModeSelection {
            GameModeSelectView(currGameScreen: $currGameScreen)
                .environmentObject(gameEngineMgr)
        } else if currGameScreen == .gameplay {
            ZStack {
                GameplayLevelView()
                    .environmentObject(gameEngineMgr)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ tap in
                            gameEngineMgr.tapEvent(at: tap.location)
                        })
                            .onEnded { _ in
                                gameEngineMgr.resetInput()
                            }
                    )

                // MARK: Comment this out later. This is for testing only
                // We need to keep this view to receive tap input
                VStack {
                    Text("Move: " + gameEngineMgr.getInput().inputType.rawValue)
                    Text("Selected GameMode: " + gameEngineMgr.gameMode.name)
                }
            }
            .ignoresSafeArea(.all)
        } else if currGameScreen == .settings {
            SettingsView(currGameScreen: $currGameScreen)
                .environmentObject(mainGameMgr)
                .environmentObject(gameEngineMgr)
        } else if currGameScreen == .achievements {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var mainGameMgrPrev = MainGameManager()

    static var previews: some View {
        ContentView(gameEngineMgr: GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
            .environmentObject(mainGameMgrPrev)
    }
}
