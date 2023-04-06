//
//  TowerHeightStatTracker.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 30/3/23.
//

import Foundation

class TowerHeightStatTracker: StatTracker {
    static let name: String = "TowerHeight"
    var height: CGFloat {
        didSet {
//            print(height)
        }
    }
    
    init(eventManager: EventManager) {
        self.height = 0
        eventManager.registerClosure(for: TowerHeightIncreasedEvent.self, closure: towerHeightUpdatedClosure)
    }
    
    private lazy var towerHeightUpdatedClosure = { [weak self] (_ event: Event) -> Void in
        guard let self = self,
              let towerHeightIncreasedEvent = event as? TowerHeightIncreasedEvent else {
            return
        }
        self.height = max(self.height, towerHeightIncreasedEvent.newHeight)
    }
}
