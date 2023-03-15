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

    var body: some View {
        ZStack {
            ScreenInputView()
                .environmentObject(gameEngineMgr)

//            GameplayLevelView()
//                .environmentObject(gameEngineMgr)
        }
        .ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var mainGameMgrPrev = MainGameManager()

    static var previews: some View {
        ContentView(gameEngineMgr: GameEngineManager(levelDimensions: .infinite))
            .environmentObject(mainGameMgrPrev)
    }
}
