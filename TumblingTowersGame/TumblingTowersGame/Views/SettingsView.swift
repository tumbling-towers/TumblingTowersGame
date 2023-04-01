//
//  SettingsView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    @StateObject var settingsMgr = SettingsManager()
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {

            BackgroundView()

            VStack {
                Text("Volume")
                    .modifier(CategoryText())

                HStack {
                    Text("Overall")
                        .modifier(BodyText())

                    Slider(value: $settingsMgr.overallVolume, in: 0.0...3.0)
                        .frame(width: 400)
                        .padding(.all)
                }


                HStack {
                    Text("Background Music")
                        .modifier(BodyText())

                    Slider(value: $settingsMgr.backgroundMusicVolume, in: 0.0...3.0)
                        .frame(width: 400)
                        .padding(.all)
                }

                HStack {
                    Text("Other Sounds")
                        .modifier(BodyText())

                    Slider(value: $settingsMgr.otherSoundVolume, in: 0.0...3.0)
                        .frame(width: 400)
                        .padding(.all)
                }

                Text("Input Sensitivity")
                    .modifier(CategoryText())

                HStack {
                    Text("Block Movement Speed")
                        .modifier(BodyText())

                    // TODO: Should we add this?
                    Slider(value: $settingsMgr.otherSoundVolume, in: 0.0...3.0)
                        .frame(width: 400)
                        .padding(.all)
                }

                Button {
                    currGameScreen = .mainMenu
                } label: {
                    Text("BACK")
                        .modifier(MenuButtonText(fontSize: 20))
                }
                .padding(.top, 35.0)
            }
        }
        .ignoresSafeArea(.all)

    }

    private func drawGameModeOption(gameMode: Constants.GameModeTypes, name: String, fontSize: CGFloat) -> AnyView {
        AnyView(
            Button {
//                gameEngineMgr.setGameMode(gameMode: gameMode)
                gameEngineMgr.startGame(gameMode: gameMode)
                currGameScreen = .gameplay
            } label: {
                Text(name)
                    .modifier(MenuButtonText(fontSize: fontSize))
            }
        )
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(currGameScreen: .constant(.gameModeSelection))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
            .environmentObject(MainGameManager())
    }
}
