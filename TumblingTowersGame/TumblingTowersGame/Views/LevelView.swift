//
//  LevelView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            ForEach($gameEngineMgr.levelBlocks) { block in
                BlockView(block: block)
            }
            
            PlatformView()
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}
