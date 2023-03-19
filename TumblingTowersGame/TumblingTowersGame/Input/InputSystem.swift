//
//  InputSystem.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation

protocol InputSystem {

    func start(levelWidth: CGFloat, levelHeight: CGFloat)

    func getInput() -> InputType

    func tapEvent(at: CGPoint)

}

enum InputType: String {
    case LEFT = "LEFT"
    case NONE = "NONE"
    case RIGHT = "RIGHT"
}
