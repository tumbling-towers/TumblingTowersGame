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
        if let position = gameEngineMgr.platformRenderPosition, let path = gameEngineMgr.platformPath {
            Image(ViewImageManager.platformImage)
                .resizable()
                .frame(
                    width: path.width,
                    height: path.height, alignment: .center)
                .position(position)
        } else {
            EmptyView()
        }
        
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}
