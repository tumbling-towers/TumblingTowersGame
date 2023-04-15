//
//  SoundSystem.swift
//  TumblingTowersGame
//
//  Created by Elvis on 24/3/23.
//

import Foundation
import AVKit
import MediaPlayer

class SoundSystem {

    static let shared = SoundSystem()
    private var backgroundMusicPlayer: AVAudioPlayer?

    private var soundPlayers: [GameSound: AVAudioPlayer] = [:]

    var backgroundMusicVolume: Float {
        if let currVol = backgroundMusicPlayer?.volume {
            return currVol
        } else {
            return 0
        }
    }

    var otherSoundVolume: Float

    var overallVolume: Float {
        AVAudioSession.sharedInstance().outputVolume
    }

    private init() {
        otherSoundVolume = 0.0

        for sound in GameSound.allCases {
            loadSound(sound)
        }
    }

    func registerSoundEvents(eventMgr: EventManager) {
        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: { [weak self] (_ event: Event) -> Void in self?.playSound(.COLLIDE) })
        eventMgr.registerClosure(for: BlockTouchedPowerupLineEvent.self, closure: { [weak self] (_ event: Event) -> Void in self?.playSound(.POWERUPCOLLECT) })
        eventMgr.registerClosure(for: GluePowerupActivatedEvent.self, closure: { [weak self] (_ event: Event) -> Void in self?.playSound(.POWERUPGLUE) })
        eventMgr.registerClosure(for: PlatformPowerupActivatedEvent.self, closure: { [weak self] (_ event: Event) -> Void in self?.playSound(.POWERUPPLATFORM) })
        eventMgr.registerClosure(for: GameEndedEvent.self, closure: { [weak self] (_ event: Event) -> Void in self?.playSound(.GAMEEND) })
    }

    private func loadSound(_ sound: GameSound) {
        var currPlayer: AVAudioPlayer

        if let path = Bundle.main.path(forResource: sound.rawValue, ofType: nil) {
            let urlToSound = URL(fileURLWithPath: path)

            do {
                currPlayer = try AVAudioPlayer(contentsOf: urlToSound)
            } catch {
                return
            }

            print("Loaded " + sound.rawValue)

            soundPlayers[sound] = currPlayer

            print(soundPlayers.count)
        }
    }

    private func playSound(_ sound: GameSound) {
        print(soundPlayers.count)
        guard let currPlayer = soundPlayers[sound] else {
            print("Cant find player for \(sound.rawValue)")
            return
        }

        print("Playing Sound \(sound.rawValue) with volume \(otherSoundVolume)")

        currPlayer.volume = exp(otherSoundVolume) - 1

        currPlayer.play()
    }

    func startBackgroundMusic() {
        if let path = Bundle.main.path(forResource: Constants.backgroundMusicFileName, ofType: nil) {
            let urlToBkgMusic = URL(fileURLWithPath: path)

            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: urlToBkgMusic)
            } catch {
                return
            }

            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.play()
        }
    }

    func changeBackgroundMusicVolume(_ newVolume: Float) {
        backgroundMusicPlayer?.setVolume(exp(newVolume) - 1, fadeDuration: TimeInterval(0.2))
    }

    func changeSoundVolume(_ newVolume: Float) {
        otherSoundVolume = newVolume
    }

    func changeOverallVolume(_ newVolume: Float) {
        let mpVolumeView = MPVolumeView()
        let slider = mpVolumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            slider?.value = newVolume
        }
    }

    enum GameSound: String, CaseIterable {
        case COLLIDE = "collide.mp3"
        case POWERUPCOLLECT = "powerup-collect.mp3"
        case POWERUPGLUE = "powerup-glue.mp3"
        case POWERUPPLATFORM = "powerup-platform.mp3"
        case GAMEEND = "result.mp3"

    }
}
