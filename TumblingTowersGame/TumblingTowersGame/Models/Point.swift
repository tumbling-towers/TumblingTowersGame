//
//  Point.swift
//  PeggleSimulator
//
//  Created by Elvis on 26/1/23.
//

import Foundation

struct Point {

    let x: Double
    let y: Double

    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    func distanceTo(otherPoint: Point) -> Double {
        let xDifference = otherPoint.x - x
        let yDifference = otherPoint.y - y

        let sumOfSquares = pow(xDifference, 2) + pow(yDifference, 2)
        let pythogarasResult = pow(sumOfSquares, 0.5)

        return pythogarasResult
    }

    func moveBy(vector: Vector) -> Point {
        Point(x + vector.x, y + vector.y)
    }
}

extension Point: Equatable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
