//
//  Vector.swift
//  PeggleSimulator
//
//  Created by Elvis on 11/2/23.
//

import Foundation

struct Vector {

    var x: Double
    var y: Double

    init() {
        self.x = 0
        self.y = 0
    }

    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    init(_ point: Point) {
        self.x = point.x
        self.y = point.y
    }

    var magnitude: Double {
        let sumOfSquares = pow(self.x, 2) + pow(self.y, 2)
        let pythogarasResult = pow(sumOfSquares, 0.5)

        return pythogarasResult
    }

    var normalized: Vector {
        if magnitude == 0 {
            return Vector()
        } else {
            return Vector(self.x / magnitude, self.y / magnitude)
        }
    }

    var reversed: Vector {
        Vector(-self.x, -self.y)
    }

    var angleToHorizontal: Double {
        atan(y / x)
    }

    func scale(multiplier: Double) -> Vector {
        Vector(x * multiplier, y * multiplier)
    }

    func add(with: Vector) -> Vector {
        Vector(x + with.x, y + with.y)
    }

    func subtract(with: Vector) -> Vector {
        Vector(x - with.x, y - with.y)
    }

    func rotate(byAngle: Double) -> Vector {
        let newAngleToHorizontal = angleToHorizontal + byAngle
        let newX = magnitude * cos(newAngleToHorizontal)
        let newY = magnitude * sin(newAngleToHorizontal)

        return Vector(newX, newY)
    }

    func runThisDirectionFor(duration: Double, startingPoint: Point) -> Point {
        let distanceMovedX = x * duration
        let distanceMovedY = y * duration

        return Point(startingPoint.x + distanceMovedX, startingPoint.y + distanceMovedY)
    }

    func moveThisDirectionFor(distance: Double, startingPoint: Point) -> Point {
        let vectorToAddToStartingPoint = normalized.scale(multiplier: distance)

        return vectorToAddToStartingPoint.runThisDirectionFor(duration: 1, startingPoint: startingPoint)
    }

}

extension Vector: Equatable {
    static func == (lhs: Vector, rhs: Vector) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}

