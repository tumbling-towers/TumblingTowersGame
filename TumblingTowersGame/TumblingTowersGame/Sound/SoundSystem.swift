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

    var otherSoundVolume: Float {
        // TODO: Update when storage implemented
        0
    }

    var overallVolume: Float {
        AVAudioSession.sharedInstance().outputVolume
//        let mpVolumeView = MPVolumeView()
//        let slider = mpVolumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
//
//        if let currVol = slider?.value {
//            return currVol
//        } else {
//            return 0
//        }
    }

    private init() {
        for sound in GameSound.allCases {
            loadSound(sound)
        }
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

            soundPlayers[sound] = currPlayer
        }
    }

    private func playSound(_ sound: GameSound) {
        guard let currPlayer = soundPlayers[sound] else {
            return
        }

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
        // TODO: Implement
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
        case POWERUP = "powerup-collect.mp3"
        case GAMEWIN = "game-win.mp3"
        case GAMELOSE = "game-lose.mp3"
        case VINES = "powerup-vines.mp3"
    }
}
