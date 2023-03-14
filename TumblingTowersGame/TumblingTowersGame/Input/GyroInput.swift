//
//  GyroInput.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import CoreMotion

class GyroInput: InputSystem {

    private weak var mainGameMgr: MainGameManager?
    private var motionManager: CMMotionManager

    private var inputVal = InputType.NONE

    init() {
        motionManager = CMMotionManager()
        motionManager.startDeviceMotionUpdates()
        motionManager.startGyroUpdates()
    }

    func start(levelWidth: CGFloat, levelHeight: CGFloat) {

    }

    func getInput() -> InputType {

        if let rate = motionManager.gyroData?.rotationRate.y {
            print("Rate: " + String(rate))
            if rate > 0 {
                return .RIGHT
            } else {
                return .LEFT
            }
        } else {
            return .NONE
        }
    }

    func tapEvent(at: Point) {
        
    }
}
