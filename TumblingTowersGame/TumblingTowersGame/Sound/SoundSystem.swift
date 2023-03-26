//
//  SoundSystem.swift
//  TumblingTowersGame
//
//  Created by Elvis on 24/3/23.
//

import Foundation
import AVKit

class SoundSystem {

    static let shared = SoundSystem()
    private var backgroundMusicPlayer: AVAudioPlayer?

    private var soundPlayers: [GameSound: AVAudioPlayer] = [:]

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

//    func startMainMusic() {
//        if let path = Bundle.main.path(forResource: FILE NAME, ofType: nil) {
//            let urlToBkgMusic = URL(fileURLWithPath: path)
//
//            do {
//                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: urlToBkgMusic)
//            } catch {
//                return
//            }
//
//            backgroundMusicPlayer?.numberOfLoops = -1
//            backgroundMusicPlayer?.prepareToPlay()
//            backgroundMusicPlayer?.play()
//        }
//    }

    enum GameSound: String, CaseIterable {
        case COLLIDE = "collide.mp3"
        case POWERUP = "powerup-collect.mp3"
        case GAMEWIN = "game-win.mp3"
        case GAMELOSE = "game-lose.mp3"
        case VINES = "powerup-vines.mp3"
    }
}
