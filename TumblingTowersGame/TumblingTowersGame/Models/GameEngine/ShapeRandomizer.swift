//
//  ShapeRandomizer.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 18/3/23.
//

import Foundation

class ShapeRandomizer {
    var rng: RandomNumberGeneratorWithSeed
    let possibleShapes: [TetrisShape]
    var bagOfShapes: Set<TetrisShape> {
        didSet {
            if bagOfShapes.isEmpty {
                bagOfShapes = Set(possibleShapes)
            }
        }
    }

    init(possibleShapes: [TetrisShape], seed: Int = 1) {
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
        self.possibleShapes = possibleShapes
        bagOfShapes = Set(possibleShapes)
    }

    func getShape() -> TetrisShape {
        guard let randomShape = bagOfShapes.randomElement(using: &rng) else {
            // TODO: throw error as this should never happen.
            return TetrisShape.L
        }
        bagOfShapes.remove(randomShape)
        return randomShape
    }
}
