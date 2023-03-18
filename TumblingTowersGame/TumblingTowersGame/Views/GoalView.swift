//
//  GoalView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import SwiftUI

struct GoalView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    
    var body: some View {
        Image(ViewImageManager.goalLineImage)
            .position(gameEngineMgr.goalLinePosition)
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}
