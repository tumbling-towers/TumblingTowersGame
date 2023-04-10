//
//  GameEndEvent.swift
//  TumblingTowersGame
//
//  Created by Elvis on 7/4/23.
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
