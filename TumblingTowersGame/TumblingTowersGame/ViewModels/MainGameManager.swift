//
//  MainGameManager.swift
//  Gyro
//
//  Created by Elvis on 11/3/23.
//

import Foundation

class MainGameManager: ObservableObject {
    var storageManager =  StorageManager()

    private(set) var deviceHeight: CGFloat = 1_920
    private(set) var deviceWidth: CGFloat = 1_080

    private var eventManager: EventManager?

    private var gameEngineMgr: GameEngineManager?
    
    func createGameEngineManager(deviceHeight: CGFloat, deviceWidth: CGFloat) -> GameEngineManager {
        self.deviceHeight = deviceHeight
        self.deviceWidth = deviceWidth

        let eventManager = TumblingTowersEventManager()

        let gameEngineMgr = GameEngineManager(levelDimensions: CGRect(x: 0, y: 0,
                                                                      width: deviceWidth, height: deviceHeight), eventManager: eventManager, storageManager: storageManager)
        self.gameEngineMgr = gameEngineMgr
        self.eventManager = eventManager
        
        return gameEngineMgr
    }

}
