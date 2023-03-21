//
//  Event.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

protocol Event {
    static var identifier: any EventIdentifier { get }
    var identifier: any EventIdentifier { get }
}

extension Event {
    func toNotification() -> TumblingTowersNotification?
}
