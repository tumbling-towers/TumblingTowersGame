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

            GameplayLevelView()
//            LevelView()
                .environmentObject(gameEngineMgr)
                .gesture(DragGesture(minimumDistance: 0)
                    .onEnded { tap in
                        let tapLocation = Point(tap.location.x, tap.location.y)
                        gameEngineMgr.tapEvent(at: tapLocation)
                        gameEngineMgr.addBlock(at: tap.location)
                    }
                )

                // MARK: Comment this out later. This is for testing only
                // We need to keep this view to receive tap input
                Text("Move: " + gameEngineMgr.getInput().rawValue)
            
//            ScreenInputView()
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
