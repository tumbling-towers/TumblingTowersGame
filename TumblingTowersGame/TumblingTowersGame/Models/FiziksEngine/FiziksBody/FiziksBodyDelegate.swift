//
//  FiziksBodyDelegate.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 21/3/23.
//

import Foundation

protocol FiziksBodyDelegate: AnyObject {
    func didUpdatePosition(to newPosition: CGPoint)
    func didUpdateRotation(to newRotation: Double)
}
