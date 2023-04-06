//
//  PowerupButtonTappedEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 31/3/23.
//

import Foundation

class PowerupButtonTappedEvent: TumblingTowersEvent {
    let idx: Int

    init(idx: Int) {
        self.idx = idx
    }
}
