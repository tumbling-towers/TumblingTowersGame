//
//  TumblingTowersGameApp.swift
//  TumblingTowersGame
//
//  Created by Elvis on 14/3/23.
//

import SwiftUI

@main
struct TumblingTowersGameApp: App {
    @StateObject var mainGameMgr = MainGameManager()

    var body: some Scene {
        WindowGroup {
            GeometryReader { geo in
                ContentView(gameEngineMgr: mainGameMgr
                    .setDeviceDimensionsAndGetGameEngineMgr(
                        deviceHeight: geo.size.height,
                        deviceWidth: geo.size.width))
                .environmentObject(mainGameMgr)
                .statusBarHidden(true)
                .onAppear {
                    SoundSystem.shared.startBackgroundMusic()
                }
            }
        }
    }
}
