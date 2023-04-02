//
//  TapInput.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation

class TapInput: InputSystem {
    var inputData = InputData.none

    private var xMultiplier: Double = 0.01
    private var yMultiplier: Double = 5.0

    func getInput() -> InputData {
        inputData
    }

    func resetInput() {
        inputData = InputData.none
    }

    func dragEvent(offset: CGSize) {
        // detected as a right drag
        if offset.width > 0 && abs(offset.height) < 50 {
            inputData = InputData(inputType: .RIGHT, vector: CGVector(dx: offset.width * xMultiplier, dy: 0))
        } else if offset.width < 0 && abs(offset.height) < 50 {
            // detected as a left drag
            inputData = InputData(inputType: .LEFT, vector: CGVector(dx: offset.width * xMultiplier, dy: 0))
        } else if abs(offset.width) < 20 && offset.height > 0 {
            // detected as a swipe down
            inputData = InputData(inputType: .DOWN, vector: InputData.unitDown * yMultiplier)
        }
    }
}
