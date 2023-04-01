// From Teng Foong

import Foundation

class GameTimer {
    var timer: Timer?
    var count: Int = 0
    var timeInMinSec: (min: Int, sec: Int) {
        let min = Int(floor(Double(count) / 60.0))
        let sec = count % 60
        return (min, sec)
    }
    var isPaused = false

    func start(timeInSeconds time: Int, countsUp: Bool) {
        if countsUp {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { self.increment($0) })
        } else {
            count = time
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { self.decrement($0) })
        }
    }

    func increment(_: Timer) {
        if !isPaused {
            count += 1
        }
    }

    func decrement(_: Timer) {
        if !isPaused {
            count -= 1
        }
    }

    func pause() {
        isPaused = true
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
