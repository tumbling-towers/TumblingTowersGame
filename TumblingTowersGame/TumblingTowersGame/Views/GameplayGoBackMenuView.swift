//
//  GameplayGoBackMenuView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 1/4/23.
//

import SwiftUI

struct GameplayGoBackMenuView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        HStack {
            Spacer()

            Button("BACK") {
                withAnimation {
                    currGameScreen = .mainMenu
                    gameEngineMgr.resetGame()
                }
            }
            .modifier(CustomButton(fontSize: 20))

            Spacer()
        }
    }
}

struct GameplayGoBackMenuView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayGoBackMenuView(currGameScreen: .constant(.gameplay))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}
