//
//  Int+SecondsToTimeStr.swift
//  TumblingTowersGame
//
//  Created by Elvis on 12/4/23.
//

import Foundation

extension Int {
    func secondsToTimeStr() -> String {
        let min = Int(floor(Double(self) / 60.0))
        let sec = self % 60
        return "\(min) min, \(sec) s"
    }
}
