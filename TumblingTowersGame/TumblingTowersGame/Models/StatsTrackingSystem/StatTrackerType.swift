//
//  StatTrackerType.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 6/4/23.
//

import Foundation

enum StatTrackerType: String, CaseIterable {
    case numBlocksPlaced
    case numBlocksDropped
    case towerHeight
}

extension StatTrackerType: Codable {

}
