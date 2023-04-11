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

                Image(ViewImageManager.mainLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500)
                    

                Spacer()

                Button {
                    withAnimation {
                        currGameScreen = .gameModeSelection
                    }
                } label: {
                    Text("Start")
                        .modifier(CustomButton(fontSize: 40))
                }
                
                Spacer().frame(height: 50)
                
                Button {
                    withAnimation {
                        currGameScreen = .achievements
                    }
                } label: {
                    Text("Achievements")
                        .modifier(CustomButton(fontSize: 40))
                }
                .modifier(CustomButton(fontSize: 40))
                
                Spacer().frame(height: 50)

                Button {
                    withAnimation {
                        currGameScreen = .settings
                    }
                } label: {
                    Text("Settings")
                        .modifier(CustomButton(fontSize: 40))
                }
                .modifier(CustomButton(fontSize: 40))

                Spacer()
                Spacer()
            }

            Button {
                withAnimation {
                    currGameScreen = .tutorial
                }
            } label: {
                Text("?")
                    .modifier(SquareCustomButton(fontSize: 50))
            }
            .modifier(SquareCustomButton(fontSize: 50))
            .position(x: gameEngineMgr.levelDimensions.width - 100, y: gameEngineMgr.levelDimensions.height - 100)

        }
        .ignoresSafeArea(.all)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(currGameScreen: .constant(.mainMenu))
            .environmentObject(MainGameManager())
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), storageManager: StorageManager()))
    }
}
