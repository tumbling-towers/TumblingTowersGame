//
//  MainGameManager.swift
//  Gyro
//
//  Created by Elvis on 11/3/23.
//

import Foundation

class MainGameManager: ObservableObject {

    private(set) var deviceHeight: CGFloat = 1_920
    private(set) var deviceWidth: CGFloat = 1_080

    private var gameEngineMgr = GameEngineManager(levelDimensions: .infinite)

    func setDeviceDimensionsAndGetGameEngineMgr(deviceHeight: CGFloat, deviceWidth: CGFloat) -> GameEngineManager {
        self.deviceHeight = deviceHeight
        self.deviceWidth = deviceWidth

        gameEngineMgr = GameEngineManager(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight))

        gameEngineMgr.setUpLevelAndStartEngine(mainGameMgr: self)

        return gameEngineMgr
    }
    
}


