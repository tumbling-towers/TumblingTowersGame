//
//  GameUpdater.swift
//  TumblingTowersGame
//
//  Created by Elvis on 18/3/23.
//

import Foundation
import SwiftUI

class GameUpdater {

    private var time: Date = .now
    private var leftoverTime: Double = 0.0
    private let durationOfFrameFor60FPS = TimeInterval(1.0 / 60.0)
    private var displayLink: CADisplayLink?
    private var frameCount = 0
    private var runThisEveryFrame: () -> Void

    var timePassed: Double {
        (Double(frameCount) + leftoverTime) * durationOfFrameFor60FPS
    }

    init(runThisEveryFrame: @escaping () -> Void) {
        self.runThisEveryFrame = runThisEveryFrame
    }

    func createCADisplayLink() {
        time = Date()

        frameCount = 0
        leftoverTime = 0

        // TODO: We need to facade DisplayLink out into our own refresh class also later
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
        let timeNow = Date()
        let timePassed = timeNow.timeIntervalSince(time) + leftoverTime
        time = timeNow

        var framesPassed = timePassed.magnitude / durationOfFrameFor60FPS
        while framesPassed > 1 {
            runThisEveryFrame()

            // FIXME: to be removed eventually
            if frameCount.isMultiple(of: 60) {
                // Things to do every 1s
                // Step every 1s instead (Temporary so that it doesnt keep printing)
                step()
            }

            framesPassed -= 1
            frameCount += 1
        }
        leftoverTime = framesPassed * durationOfFrameFor60FPS
    }

    @objc func step() {

    }
}
