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
        return ZStack {
            GameplayLevelView()
                .environmentObject(gameEngineMgr)
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged({ tap in
                        gameEngineMgr.tapEvent(at: tap.location)
                    })
                    .onEnded { tap in
                        gameEngineMgr.resetInput()
                    }
                )

                // MARK: Comment this out later. This is for testing only
                // We need to keep this view to receive tap input
            Text("Move: " + gameEngineMgr.getInput().inputType.rawValue)
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
