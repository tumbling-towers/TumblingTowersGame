//
//  EventIdentifier.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

protocol EventIdentifier: Hashable {
    var id: Int { get }
    var notificationName: NotificationName { get set }
}
