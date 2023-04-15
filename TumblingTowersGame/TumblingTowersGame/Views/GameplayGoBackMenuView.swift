//
//  GameplayGoBackMenuView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 1/4/23.
//

import SwiftUI

struct GameplayGoBackMenuView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        HStack {
            Spacer()

            Button {
                withAnimation {
                    currGameScreen = .mainMenu
                    mainGameMgr.stopGames()
                    mainGameMgr.resetGames()
                    mainGameMgr.removeAllGameEngineMgrs()
                    mainGameMgr.gameMode = nil
                }
            } label: {
                Text("Back")
                    .modifier(CustomButton(fontSize: 40))
            }

            Spacer()
        }
    }
}

struct GameplayGoBackMenuView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayGoBackMenuView(currGameScreen: .constant(.singleplayerGameplay))
    }
}
