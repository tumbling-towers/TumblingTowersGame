//
//  Double+truncate.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 11/4/23.
//

import Foundation

extension Double {
    func truncate(places: Int) -> Double {
        Double(floor(pow(10.0, Double(places)) * self) / pow(10.0, Double(places)))
    }
}
