//
//  InputSystem.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation

protocol InputSystem {

    init()

    static var description: String { get }
    
    func calculateInput() -> InputData

    func dragEvent(offset: CGSize)

    func resetInput()

}

struct InputData {
    let inputType: InputType
    let vector: CGVector

    static let none = InputData(inputType: .NONE, vector: .zero)
    static let unitLeft = CGVector(dx: -1.0, dy: 0)
    static let unitRight = CGVector(dx: 1.0, dy: 0)
    static let unitDown = CGVector(dx: 0, dy: -1.0)
}

enum InputType: String {
    case LEFT
    case NONE
    case RIGHT
    case DOWN
}
