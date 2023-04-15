//
//  GameWorld+FiziksContactDelegate.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 9/4/23.
//

import Foundation

extension GameWorld: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {
        // check whether it is contact between currently moving block & something else (not level boundaries)
        guard let currentBlock = currentlyMovingBlock else {
            return
        }
        if contact.contains(body: currentBlock.fiziksBody)
            && !cmbContactedBoundary(contact: contact) {
            handlePlaceCMB()
        }
        
        SpecialPropertiesContactResolver.resolve(fiziksEngine: fiziksEngine,
                                                 contact: contact,
                                                 specialProperties: currentBlock.specialProperties)
    }
    
    private func cmbContactedBoundary(contact: FiziksContact) -> Bool {
        contact.contains(body: level.leftBoundary?.fiziksBody)
        || contact.contains(body: level.rightBoundary?.fiziksBody)
    }

    func didEnd(_ contact: FiziksContact) {
        // pass
    }

    private func handlePlaceCMB() {
        // allow gravity and rotation by collisions
        currentlyMovingBlock?.fiziksBody.affectedByGravity = true
        currentlyMovingBlock?.fiziksBody.allowsRotation = true

        // update collsion and contact mask
        currentlyMovingBlock?.fiziksBody.collisionBitMask = Block.collisionBitMask
        currentlyMovingBlock?.fiziksBody.contactTestBitMask = Block.contactTestBitMask

        updatePlacedBlocksStatus()
        updateTowerHeight()
        insertNewBlock()
    }

    private func updatePlacedBlocksStatus() {
        var placedBlockCount = 0
        for gameObject in level.gameObjects {
            if gameObject.fiziksBody.categoryBitMask == CategoryMask.block {
                placedBlockCount += 1
            }
        }
        eventManager.postEvent(BlockPlacedEvent(totalBlocksInLevel: placedBlockCount, playerId: playerId))

    }

    private func updateTowerHeight() {
        let towerHeight = level.getHighestPoint(excluding: currentlyMovingBlock)
        eventManager.postEvent(TowerHeightIncreasedEvent(newHeight: towerHeight))
    }
}
