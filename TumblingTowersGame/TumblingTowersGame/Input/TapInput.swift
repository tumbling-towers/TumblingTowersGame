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

    private var inputData: InputData = InputData.none

    func start(levelWidth: CGFloat, levelHeight: CGFloat) {
        self.levelWidth = levelWidth
        self.levelHeight = levelHeight
    }

    func getInput() -> InputData {
        inputData
    }

    func resetInput() {
        inputData = InputData.none
    }

    func tapEvent(at: CGPoint) {
        if at.x > levelWidth / 2 {
            inputData = InputData(inputType: .RIGHT, vector: InputData.unitRight)
        } else {
            inputData = InputData(inputType: .LEFT, vector: InputData.unitLeft)
        }
    }
}
