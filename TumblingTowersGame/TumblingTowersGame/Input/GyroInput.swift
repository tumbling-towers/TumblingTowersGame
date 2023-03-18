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

        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates()
        }

        if motionManager.isGyroAvailable {
            motionManager.startGyroUpdates()
        }

        if motionManager.isAccelerometerAvailable {
            motionManager.startAccelerometerUpdates()
        }
    }

    func start(levelWidth: CGFloat, levelHeight: CGFloat) {

    }

    func getInput() -> InputType {

        if let rate = motionManager.accelerometerData?.acceleration.x {
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
