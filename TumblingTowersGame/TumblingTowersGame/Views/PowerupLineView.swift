//
//  PowerupLineView.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 27/3/23.
//

import Foundation
import SwiftUI

struct PowerupLineView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    
    static let color = Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1),
        opacity: 1
    )

    var body: some View {
        return PathViewShape(cgPath: CGPath(rect: CGRect(x: gameEngineMgr.powerUpLinePosition.x,
                                                         y: gameEngineMgr.powerUpLinePosition.y,
                                                         width: gameEngineMgr.powerupLineDimensions.width,
                                                         height: gameEngineMgr.powerupLineDimensions.height), transform: nil))
                .fill(.red)
//                .position(gameEngineMgr.powerUpLinePosition)
                
    }
}
//
//struct PowerupLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        PowerupLineView(block: .constant(GameObjectBlock.sampleBlock))
//            .environmentObject(GameEngineManager(levelDimensions: .infinite))
//    }
//}
