//
//  GameUpdater.swift
//  TumblingTowersGame
//
//  Created by Elvis on 18/3/23.
//

import Foundation
import SwiftUI

class GameUpdater {

    private var displayLink: CADisplayLink?
    private var runThisEveryFrame: () -> Void

    init(runThisEveryFrame: @escaping () -> Void) {
        self.runThisEveryFrame = runThisEveryFrame
    }

    func createCADisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .common)
    }

    func pauseGame() {
        displayLink?.isPaused = true
    }

    func unpauseGame() {
        displayLink?.isPaused = false
    }

    func stopLevel() {
        displayLink?.isPaused = true
        displayLink?.invalidate()
    }

    @objc func update() {
        runThisEveryFrame()
    }

}
