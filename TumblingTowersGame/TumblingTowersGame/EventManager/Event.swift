//
//  Event.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

protocol Event {
    static var identifier: EventIdentifier { get }
    var identifier: EventIdentifier { get }
    func toNotification() -> TumblingTowersNotification
}

//extension Event {
//}
