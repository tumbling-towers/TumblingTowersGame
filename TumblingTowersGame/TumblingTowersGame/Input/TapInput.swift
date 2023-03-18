//
//  TapInput.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation

class TapInput: InputSystem {

    private var levelWidth: CGFloat = 0
    private var levelHeight: CGFloat = 0
    private var inputVal = InputType.NONE

    func start(levelWidth: CGFloat, levelHeight: CGFloat) {
        self.levelWidth = levelWidth
        self.levelHeight = levelHeight
    }

    func getInput() -> InputType {
        inputVal
    }

    func tapEvent(at: CGPoint) {
        if at.x > levelWidth / 2 {
            inputVal = .RIGHT
        } else {
            inputVal = .LEFT
        }
    }
}
