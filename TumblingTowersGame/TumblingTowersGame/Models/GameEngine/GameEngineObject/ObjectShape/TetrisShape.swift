//
//  Shape.swift
//  Facade
//
//  Created by Quan Teng Foong on 11/3/23.
//

import CoreGraphics
import Foundation

enum TetrisType: CaseIterable {
    case I, J, L, O, S, T, Z
}

struct TetrisShape: PathObjectShape {
    typealias P = CGPoint
    
    let type: TetrisType
    
    static let shapeToPoints: [TetrisType: [P]] = [.L: [P(x: -15, y: -10),
                                                        P(x: -5, y: -10),
                                                        P(x: -5, y: 0),
                                                        P(x: 15, y: 0),
                                                        P(x: 15, y: 10),
                                                        P(x: -15, y: 10)],
                                                   .I: [P(x: -5, y: -20),
                                                        P(x: 5, y: -20),
                                                        P(x: 5, y: 20),
                                                        P(x: -5, y: 20)],
                                                   .J: [P(x: -15, y: -10),
                                                        P(x: 15, y: -10),
                                                        P(x: 15, y: 0),
                                                        P(x: -5, y: 0),
                                                        P(x: -5, y: 10),
                                                        P(x: -15, y: 10)],
                                                   .O: [P(x: -10, y: -10),
                                                        P(x: 10, y: -10),
                                                        P(x: 10, y: 10),
                                                        P(x: -10, y: 10)],
                                                   .Z: [P(x: -5, y: -10),
                                                        P(x: 15, y: -10),
                                                        P(x: 15, y: 0),
                                                        P(x: 5, y: 0),
                                                        P(x: 5, y: 10),
                                                        P(x: -15, y: 10),
                                                        P(x: -15, y: 0),
                                                        P(x: -5, y: 0)],
                                                   .T: [P(x: -15, y: -10),
                                                        P(x: 15, y: -10),
                                                        P(x: 15, y: 0),
                                                        P(x: 5, y: 0),
                                                        P(x: 5, y: 10),
                                                        P(x: -5, y: 10),
                                                        P(x: -5, y: 0),
                                                        P(x: -15, y: 0)],
                                                   .S: [P(x: -15, y: -10),
                                                        P(x: 5, y: -10),
                                                        P(x: 5, y: 0),
                                                        P(x: 15, y: 0),
                                                        P(x: 15, y: 10),
                                                        P(x: -5, y: 10),
                                                        P(x: -5, y: 0),
                                                        P(x: -15, y: 0)]]
    
    init(type: TetrisType) {
        self.type = type
    }

    var points: [P] {
        // TODO: this coalace should not happen. Should throw error if cannot find.
        TetrisShape.shapeToPoints[type] ?? [CGPoint()]
    }

    var path: CGPath {
        CGPath.create(from: points)
    }
    
    var height: Double {
        path.height
    }
    
    var width: Double {
        path.width
    }
}
