//
//  ScreenInputView.swift
//  Gyro
//
//  Created by Elvis on 11/3/23.
//

import SwiftUI

struct ScreenInputView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                Image("background")
                    .resizable()
                    .scaledToFill()
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onEnded { tap in
                    let tapLocation = Point(tap.location.x, tap.location.y)
                    gameEngineMgr.tapEvent(at: tapLocation)
                }
            )

            // MARK: Comment this out later. This is for testing only
            // We need to keep this view to receive tap input
            Text("Move: " + gameEngineMgr.getInput().rawValue)
        }

    }
}

struct ScreenInputView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenInputView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}
