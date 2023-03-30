//
//  NumBlocksLostStatTracker.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class NumBlocksLostStatTracker: StatTracker {
    static let name: String = "NumBlocksLost"
    var numBlocksLost: Int
    
    init(eventManager: EventManager) {
        self.numBlocksLost = 0
        eventManager.registerClosure(for: BlockLostEvent.self, closure: { [weak self] (event: Event) in
            self?.numBlocksLost += 1
        })
    }
}
