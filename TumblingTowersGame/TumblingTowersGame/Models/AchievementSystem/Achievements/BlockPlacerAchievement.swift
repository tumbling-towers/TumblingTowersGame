//
//  NumBlocksPlacedAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class BlockPlacerAchievement: Achievement {
    var name: String = "Block Placer"
    var achievementDescription: String {
        "Place \(goal) blocks."
    }
    var progressDescription: String {
        "\(numBlocksPlaced) out of \(goal) placed."
    }
    
    var numBlocksPlaced: Int {
        didSet {
            print(numBlocksPlaced)
        }
    }
    let goal: Int
    
    init(eventManager: EventManager) {
        self.numBlocksPlaced = 0
        self.goal = 50
        eventManager.registerClosure(for: BlockPlacedEvent.self, closure: { [weak self] (event: Event) in
            self?.numBlocksPlaced += 1
        })
    }
}
