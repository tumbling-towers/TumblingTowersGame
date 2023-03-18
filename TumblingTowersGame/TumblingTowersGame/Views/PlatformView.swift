//
//  PlatformView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import SwiftUI

struct PlatformView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    
    var body: some View {
        Image(ViewImageManager.platformImage)
            .position(gameEngineMgr.platformPosition)
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}
