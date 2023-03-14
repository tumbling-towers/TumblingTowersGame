//
//  Shape.swift
//  Facade
//
//  Created by Quan Teng Foong on 11/3/23.
//

import CoreGraphics
import Foundation

enum TetrisShape: PathFiziksShape {
    case I, J, L, O, S, T, Z

    typealias P = CGPoint
    static let shapeToPoints: [TetrisShape: [P]] = [L: [P(x: 0, y: 0),
                                                        P(x: 10, y: 0),
                                                        P(x: 10, y: 10),
                                                        P(x: 30, y: 10),
                                                        P(x: 30, y: 20),
                                                        P(x: 0, y: 20)],
                                                    I: [P(x: 0, y: 0),
                                                        P(x: 10, y: 0),
                                                        P(x: 10, y: 40),
                                                        P(x: 0, y: 40)],
                                                    J: [P(x: 10, y: 0),
                                                        P(x: 20, y: 0),
                                                        P(x: 20, y: 30),
                                                        P(x: 0, y: 30),
                                                        P(x: 0, y: 20),
                                                        P(x: 10, y: 20)],
                                                    O: [P(x: 0, y: 0),
                                                        P(x: 20, y: 0),
                                                        P(x: 20, y: 20),
                                                        P(x: 0, y: 20)],
                                                    S: [P(x: 10, y: 0),
                                                        P(x: 30, y: 0),
                                                        P(x: 30, y: 10),
                                                        P(x: 20, y: 20),
                                                        P(x: 20, y: 20),
                                                        P(x: 0, y: 20),
                                                        P(x: 0, y: 10),
                                                        P(x: 10, y: 10)],
                                                    T: [P(x: 0, y: 0),
                                                        P(x: 30, y: 0),
                                                        P(x: 30, y: 10),
                                                        P(x: 20, y: 10),
                                                        P(x: 20, y: 20),
                                                        P(x: 10, y: 20),
                                                        P(x: 10, y: 10),
                                                        P(x: 0, y: 10)],
                                                    Z: [P(x: 0, y: 0),
                                                        P(x: 20, y: 0),
                                                        P(x: 20, y: 10),
                                                        P(x: 30, y: 10),
                                                        P(x: 30, y: 20),
                                                        P(x: 10, y: 20),
                                                        P(x: 10, y: 10),
                                                        P(x: 0, y: 10)]]

    var points: [P] {
        // TODO: this coalace should not happen. Should throw error if cannot find.
        TetrisShape.shapeToPoints[self] ?? [CGPoint()]
    }

    var path: CGPath {
        CGPath.create(from: points)
    }
}
