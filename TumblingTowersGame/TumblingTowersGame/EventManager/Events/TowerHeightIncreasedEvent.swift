//
//  TowerHeightIncreasedEvent.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 30/3/23.
//

import Foundation

class TowerHeightIncreasedEvent: TumblingTowersEvent {
    let newHeight: CGFloat
    
    init(newHeight: CGFloat) {
        self.newHeight = newHeight
    }
}
