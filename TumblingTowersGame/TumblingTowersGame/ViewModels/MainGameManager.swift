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

    private var eventManager: EventManager?

    private var gameEngineMgr = GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager())

    func setDeviceDimensionsAndGetGameEngineMgr(deviceHeight: CGFloat, deviceWidth: CGFloat) -> GameEngineManager {
        self.deviceHeight = deviceHeight
        self.deviceWidth = deviceWidth

        let eventManager = TumblingTowersEventManager()

        gameEngineMgr = GameEngineManager(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), eventManager: eventManager)

        self.eventManager = eventManager

        gameEngineMgr.setUpLevelAndStartEngine(mainGameMgr: self)

        return gameEngineMgr
    }

}
