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

                Button("Start") {
                    withAnimation {
                        currGameScreen = .gameModeSelection
                    }
                }
                .modifier(CustomButton(fontSize: 40))
                .frame(width: 300)
                
                Spacer().frame(height: 50)
                
                Button("Achievements") {
                    withAnimation {
                        currGameScreen = .achievements
                    }
                }
                .modifier(CustomButton(fontSize: 40))
                .frame(width: 300)
                
                Spacer().frame(height: 50)

                Button("Settings") {
                    withAnimation {
                        currGameScreen = .settings
                    }
                }
                .modifier(CustomButton(fontSize: 40))
                .frame(width: 300)

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
