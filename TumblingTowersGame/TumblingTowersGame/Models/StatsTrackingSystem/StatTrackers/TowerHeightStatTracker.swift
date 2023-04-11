//
//  TowerHeightStatTracker.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 30/3/23.
//

import Foundation

class TowerHeightStatTracker: StatTracker {
    static let name: String = "TowerHeight"
    var stat: Double
    let statTrackerType: StatTrackerType = .towerHeight
    
    init(eventManager: EventManager, stat: Double? = 0.0) {
        self.stat = stat ?? 0
        eventManager.registerClosure(for: TowerHeightIncreasedEvent.self, closure: towerHeightUpdatedClosure)
    }
    
    private lazy var towerHeightUpdatedClosure = { [weak self] (_ event: Event) -> Void in
        guard
              let towerHeightIncreasedEvent = event as? TowerHeightIncreasedEvent else {
            return
        }
        self?.stat = max(self?.stat ?? 0.0, towerHeightIncreasedEvent.newHeight)
        print("new tower height: \(self?.stat)")
    }
}
