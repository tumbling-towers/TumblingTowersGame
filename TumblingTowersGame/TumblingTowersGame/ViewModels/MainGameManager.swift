//
//  MainGameManager.swift
//  Gyro
//
//  Created by Elvis on 11/3/23.
//

import Foundation

class MainGameManager: ObservableObject {
    var storageManager =  StorageManager()

    var deviceHeight: CGFloat = 1_920
    var deviceWidth: CGFloat = 1_080

    private var eventManager: EventManager?

    var gameEngineMgrs: [GameEngineManager] = []
    
    var playersMode: PlayersMode?
    
    var inputSystem: InputSystem = GyroInput()
    
    var gameMode: Constants.GameModeTypes?
    
    func createGameEngineManager(height: CGFloat, width: CGFloat) -> GameEngineManager {
        let eventManager = TumblingTowersEventManager()

        let gameEngineMgr = GameEngineManager(levelDimensions: CGRect(x: 0, y: 0,
                                                                  width: width, height: height), eventManager: eventManager)
        gameEngineMgr.inputSystem = self.inputSystem
        self.gameEngineMgrs.append(gameEngineMgr)
        self.eventManager = eventManager
        
        return gameEngineMgr
    }
    
    func changeInput(to inputType: Constants.GameInputTypes) {
        let inputClass = Constants.getGameInputType(fromGameInputType: inputType)
        if let inputClass = inputClass {
            inputSystem = inputClass.init()
        }
    }
    
    func stopGames() {
        gameEngineMgrs.forEach({ $0.stopGame() })
    }
    
    func dragEvent(offset: CGSize) {
        inputSystem.dragEvent(offset: offset)
    }
    
    func resetInput() {
        inputSystem.resetInput()
    }
    
    func removeAllGameEngineMgrs() {
        gameEngineMgrs.removeAll()
    }
}
