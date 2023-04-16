//
//  SpecialPropertiesContactResolver.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 6/4/23.
//

import Foundation
import Fiziks

class SpecialPropertiesContactResolver {
    static func resolve(fiziksEngine: FiziksEngine, contact: FiziksContact, specialProperties: SpecialProperties) {
        if specialProperties.isGlue {
            fiziksEngine.combine(bodyA: contact.bodyA, bodyB: contact.bodyB, at: contact.contactPoint)
        }
    }
}
