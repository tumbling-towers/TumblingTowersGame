//
//  GameEndedEvent.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 8/4/23.
//

import Foundation

class GameEndedEvent: TumblingTowersEvent {
    let playerId: UUID
    let endState: Constants.GameState

    init(playerId: UUID, endState: Constants.GameState) {
        self.playerId = playerId
        self.endState = endState
    }
}
