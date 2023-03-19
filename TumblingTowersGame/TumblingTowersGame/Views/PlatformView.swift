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
            .resizable()
            .position(CGPoint(
                x: gameEngineMgr.levelDimensions.width / 2,
                y:  gameEngineMgr.levelDimensions.height - 100))
            .frame(
                width: gameEngineMgr.levelDimensions.width,
                height: (gameEngineMgr.levelDimensions.height + 200) / 2, alignment: .center)
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}
