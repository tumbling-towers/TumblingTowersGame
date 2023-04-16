//
//  RandomNumberGeneratorWithSeed.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 18/3/23.
//

import Foundation

struct RandomNumberGeneratorWithSeed: RandomNumberGenerator {
    init(seed: Int) {
        // Set the random seed
        srand48(seed)
    }

    func next() -> UInt64 {
        // drand48() returns a Double, transform to UInt64

        // This is a legacy function and will show up as a warning
        // on swiftlint, but it is necessary as type.random(in:) does
        // not support seeding
        return withUnsafeBytes(of: drand48()) { bytes in
            bytes.load(as: UInt64.self)
        }
    }
}
