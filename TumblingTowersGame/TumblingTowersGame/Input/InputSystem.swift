//
//  InputSystem.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation

protocol InputSystem {

    func start(levelWidth: CGFloat, levelHeight: CGFloat)

    func getInput() -> InputData

    func tapEvent(at: CGPoint)
    
    func resetInput()

}

struct InputData {
    let inputType: InputType
    let vector: CGVector
    
    static let none = InputData(inputType: .NONE, vector: .zero)
    static let unitLeft: CGVector = CGVector(dx: -1.0, dy: 0)
    static let unitRight: CGVector = CGVector(dx: 1.0, dy: 0)
}

enum InputType: String {
    case LEFT = "LEFT"
    case NONE = "NONE"
    case RIGHT = "RIGHT"
}
