//
//  ShapeRandomizer.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 18/3/23.
//

import Foundation

class ShapeRandomizer {
    var rng: RandomNumberGeneratorWithSeed
    let possibleShapes: [TetrisType]
    var bagOfShapes: Set<TetrisType> {
        didSet {
            if bagOfShapes.isEmpty {
                bagOfShapes = Set(possibleShapes)
            }
        }
    }

    init(possibleShapes: [TetrisType], seed: Int = 1) {
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
        self.possibleShapes = possibleShapes
        bagOfShapes = Set(possibleShapes)
    }

    func createRandomShape() -> TetrisShape {
        guard let randomShape = bagOfShapes.randomElement(using: &rng) else {
            assert(false)
        }
        bagOfShapes.remove(randomShape)
        return TetrisShape(type: randomShape)
    }
}
