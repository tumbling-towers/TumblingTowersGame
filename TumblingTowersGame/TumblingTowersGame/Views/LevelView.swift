//
//  LevelView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @EnvironmentObject var viewAdapter: ViewAdapter
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {
            LevelBackgroundView()

            ForEach($viewAdapter.levelBlocks) { block in
                BlockView(block: block)
            }

            ForEach($viewAdapter.levelPlatforms) { platform in
                PlatformView(platform: platform)
            }

            PowerupLineView()

            Rectangle()
                .path(in: viewAdapter.referenceBox)
                .fill(.blue.opacity(0.1), strokeBorder: .blue)

            GameplayGuiView(currGameScreen: $currGameScreen)
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(currGameScreen: .constant(.singleplayerGameplay))
            .environmentObject(ViewAdapter(levelDimensions: .infinite,
                                           gameEngineMgr: GameEngineManager(levelDimensions: .infinite,
                                                                            eventManager: TumblingTowersEventManager(),
                                                                            inputType: TapInput.self,
                                                                            storageManager: StorageManager(),
                                                                            playersMode: .singleplayer)))
    }
}
