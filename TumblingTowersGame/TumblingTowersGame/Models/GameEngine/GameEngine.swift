//
//  GameEngine.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI

class GameEngine {

    let levelDimensions: CGRect

    var gameObjects: [any GameEngineObject]

    var fiziksEngine: FiziksEngine

    var eventManager: EventManager? {
        didSet {
            powerupManager.eventManager = eventManager
            registerPowerupEvents()
        }
    }

    var powerupLine: PowerupLine?

    var powerupManager: PowerupManager

    var platform: Platform? {
        didSet {
            if let platform = platform {
                // boundaries set to have a buffer to allow blocks to fall off or creative gameplay

                let leftPosition = CGPoint(x: platform.position.x - GameEngineConstants.defaultPlatformBoundaryBuffer, y: levelDimensions.midY)
                let rightPosition = CGPoint(x: platform.position.x + GameEngineConstants.defaultPlatformBoundaryBuffer, y: levelDimensions.midY)

                // set up boundaries with buffer relative to platform
                rightBoundary = createLevelBoundary(at: rightPosition)
                leftBoundary = createLevelBoundary(at: leftPosition)

                // set up initial powerup line relative to platform
                let centerPosition = CGPoint(x: platform.position.x,
                                             y: platform.position.y + platform.shape.height / 2 + GameEngineConstants.defaultInitialPowerupHeight)

                powerupLine = createPowerupLine(at: centerPosition)
            }

        }
    }

    var leftBoundary: FiziksBody? {
        didSet {
            // remove the old boundary
            if let oldValue = oldValue {
                fiziksEngine.delete(oldValue)
            }
        }
    }

    var rightBoundary: FiziksBody? {
        didSet {
            // remove the old boundary
            if let oldValue = oldValue {
                fiziksEngine.delete(oldValue)
            }
        }
    }

    // TODO: Add random generation of platform in the future
    private var rng: RandomNumberGeneratorWithSeed

    private weak var gameRenderer: GameRendererDelegate?

    private var shapeRandomizer: ShapeRandomizer

    private var currentlyMovingBlock: Block? {
        didSet {
            if currentlyMovingBlock == nil {
                insertNewBlock()
            }
        }
    }

    private var blockInsertionPoint: CGPoint {
        CGPoint(x: levelDimensions.width / 2,
                y: levelDimensions.height + 30)
    }

    init(levelDimensions: CGRect, seed: Int = GameEngineConstants.defaultSeed) {
        self.levelDimensions = levelDimensions
        // Use leveldimensions to set size of level if needed, otherwise remove
        self.gameObjects = []

        // FiziksBodies will collide with walls at the sides,
        // but there is 100px above and below
        let fiziksEngineBoundingRect = CGRect(x: levelDimensions.minX,
                                              y: levelDimensions.minY - 100,
                                              width: levelDimensions.width,
                                              height: levelDimensions.height + 200)
        self.fiziksEngine = GameFiziksEngine(size: levelDimensions)
        self.fiziksEngine.insertBounds(fiziksEngineBoundingRect)

        self.shapeRandomizer = ShapeRandomizer(possibleShapes: TetrisType.allCases, seed: seed)
        self.powerupManager = GamePowerupManager(eventManager: eventManager, seed: seed)

        self.rng = RandomNumberGeneratorWithSeed(seed: seed)

        fiziksEngine.fiziksContactDelegate = self
    }

    func setRenderer(gameRenderer: GameRendererDelegate) {
        self.gameRenderer = gameRenderer
    }

    // TODO: Maybe should move this to GameEngineManager - shouldn't use GameObjectBlock here!
    func getReferencePoints() -> (left: CGPoint, right: CGPoint)? {
        guard let block = currentlyMovingBlock, let shape = currentlyMovingBlock?.shape as? TetrisShape else { return nil }
        let movingGameObjectBlock = GameObjectBlock(position: block.position, path: shape.path, rotation: block.rotation)
        let xPosLeft: Double = movingGameObjectBlock.position.x - movingGameObjectBlock.width / 2
        let xPosRight: Double = movingGameObjectBlock.position.x + movingGameObjectBlock.width / 2
        let yPos: Double = 0
        return (left: CGPoint(x: xPosLeft, y: yPos), right: CGPoint(x: xPosRight, y: yPos))
    }

    func startGame() {
        insertNewBlock()
    }

    func resetGame() {
        // TODO: Remove all blocks from level, reset all game state
        // Please help me to see if I resetted everything properly, thanks
        self.gameObjects = []

        self.platform = nil
        self.currentlyMovingBlock = nil

        let fiziksEngineBoundingRect = CGRect(x: levelDimensions.minX,
                                              y: levelDimensions.minY - 100,
                                              width: levelDimensions.width,
                                              height: levelDimensions.height + 200)
        self.fiziksEngine = GameFiziksEngine(size: levelDimensions)
        self.fiziksEngine.insertBounds(fiziksEngineBoundingRect)

        // Reset the rng generator?
        // self.rng.resetWithCurrentSeed()

        fiziksEngine.fiziksContactDelegate = self
    }

    // This update method is called by the GameUpdater every frame.
    func update() {
        // MARK: Platform is always sampleplatform for now
        var newLevel = Level(blocks: [], platforms: [])
        for object in gameObjects {
            if isOutOfBounds(object) {
                // TODO: Emit event that a block has gone out of bounds.
                removeObject(object: object)

                if object === currentlyMovingBlock {
                    currentlyMovingBlock = nil
                }
            }

            if object.fiziksBody.categoryBitMask == CategoryMask.block {
                let blockPosition = object.position
                // TODO: more elegant way besides downcasting?
                guard let block = object as? Block, let shape = block.shape as? TetrisShape else { continue }

                let newBlock = GameObjectBlock(position: blockPosition,
                                               path: shape.path,
                                               rotation: block.rotation,
                                               isGlue: block.isGlueBlock)

                newLevel.add(block: newBlock)
                checkAndHandleContactPowerupLine(currentBlock: block)
            }

            if object.fiziksBody.categoryBitMask == CategoryMask.platform {
                let newPlatform = GameObjectPlatform(position: object.position,
                                                     width: object.width,
                                                     height: object.height)
                newLevel.add(platform: newPlatform)
            }
        }

        gameRenderer?.renderLevel(level: newLevel, gameObjectBlocks: newLevel.blocks, gameObjectPlatforms: newLevel.platforms)

        // Get curr input and move block
        if let currInput = gameRenderer?.getCurrInput() {
            moveCMB(by: currInput.vector)
        }
    }

    @discardableResult
    func insertNewBlock() -> Block {
        let shape = shapeRandomizer.getShape()
        let insertedBlock = addBlock(ofShape: shape, at: blockInsertionPoint)

        // initially inserted blocks cannot rotate from collisions
        insertedBlock.fiziksBody.allowsRotation = false

        currentlyMovingBlock = insertedBlock
        return insertedBlock
    }

    /// Slides the currently-moving block only on the x-axis.
    func moveCMBSideways(by displacement: CGVector) {
        let correctedDisplacement = CGVector(dx: displacement.dx, dy: 0)
        moveCMB(by: correctedDisplacement)
    }

    /// Moves the currently-moving block downwards only.
    func moveCMBDown(by displacement: CGVector) {
        let correctedDy = min(displacement.dy, 0)
        let correctedDisplacement = CGVector(dx: 0, dy: correctedDy)
        moveCMB(by: correctedDisplacement)
    }

    /// Rotates the currently moving block clockwise by 90 degrees.
    func rotateCMBClockwise() {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        fiziksBodyToMove.zRotation -= CGFloat.pi / 2
    }

    /// Rotates the currently moving block counter-clockwise by 90 degrees.
    func rotateCMBCounterClockwise() {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        fiziksBodyToMove.zRotation += CGFloat.pi / 2
    }

    func setInitialPlatform(position: CGPoint) {
        // TODO: Add random generation of platform sizes here
        let width = 200
        let height = 100

        let points = [CGPoint(x: 0, y: height),
                      CGPoint(x: width, y: height),
                      CGPoint(x: width, y: 0),
                      CGPoint(x: 0, y: 0)]

        let path = CGPath.create(from: points)

        let insertedPlatform = createPlatform(path: path, at: position)

        platform = insertedPlatform

        gameObjects.append(insertedPlatform)
        fiziksEngine.add(insertedPlatform.fiziksBody)

        insertedPlatform.fiziksBody.affectedByGravity = false
    }

    @discardableResult
    private func addBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newBlock = createBlock(ofShape: shape, at: position)
        gameObjects.append(newBlock)
        fiziksEngine.add(newBlock.fiziksBody)
        newBlock.fiziksBody.affectedByGravity = false
        newBlock.fiziksBody.velocity = .zero
        newBlock.fiziksBody.applyImpulse(GameEngineConstants.defaultBlockVelocity)
        return newBlock
    }

    private func removeObject(object: GameEngineObject) {
        gameObjects.removeAll(where: { $0 === object })
        fiziksEngine.delete(object.fiziksBody)
    }

    // MARK: private methods
    private func createBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newFiziksBody = PathFiziksBody(path: shape.path,
                                           position: position,
                                           isDynamic: true,
                                           restitution: .zero,
                                           linearDamping: .zero,
                                           categoryBitMask: Block.categoryBitMask,
                                           collisionBitMask: Block.fallingCollisionBitMask,
                                           contactTestBitMask: Block.fallingContactTestBitMask)
        let newBlock = Block(fiziksBody: newFiziksBody, shape: shape)
        return newBlock
    }

    private func createPlatform(path: CGPath, at position: CGPoint) -> Platform {
        let newFiziksBody = PathFiziksBody(path: path,
                                           position: position,
                                           zRotation: .zero,
                                           isDynamic: false,
                                           restitution: .zero,
                                           categoryBitMask: Platform.categoryBitMask,
                                           collisionBitMask: Platform.collisionBitMask,
                                           contactTestBitMask: Platform.contactTestBitMask)
        let newPlatform = Platform(fiziksBody: newFiziksBody, shape: PlatformShape(path: path))
        return newPlatform
    }

    private func isOutOfBounds(_ obj: any GameEngineObject) -> Bool {
        let width = obj.shape.width
        let height = obj.shape.height
        let buffer = max(width, height)
        let pos = obj.position
        // doesn't include being above the level dimensions (so that objects can spawn from above)
        return pos.x - buffer > levelDimensions.maxX || pos.x + buffer < levelDimensions.minX || pos.y + buffer < 0
    }

    /// Creates  a FiziksBody to represent the level boundary.
    private func createLevelBoundary(at position: CGPoint) -> FiziksBody {
        let levelBoundaryWidth: CGFloat = 5
        let position = CGPoint(x: position.x - levelBoundaryWidth / 2, y: position.y - levelBoundaryWidth / 2)
        let rect = CGRect(origin: position, size: CGSize(width: levelBoundaryWidth, height: levelDimensions.height))

        let path = CGPath.create(from: rect, centered: true)

        let fiziksBody = PathFiziksBody(path: path,
                                        position: position,
                                        categoryBitMask: CategoryMask.levelBoundary,
                                        collisionBitMask: CollisionMask.levelBoundary)
        fiziksEngine.add(fiziksBody)
        fiziksBody.isDynamic = false
        return fiziksBody
    }

    private func updatePowerupHeight() {
        guard let powerupLine = powerupLine else { return }
        let position = powerupLine.position

        powerupLine.fiziksBody.position = position.add(by: CGVector(dx: 0, dy: GameEngineConstants.defaultPowerupHeightStep))

        powerupManager.createNextPowerup()
    }

    private func createPowerupLine(at pos: CGPoint) -> PowerupLine {
        let rect = CGRect(x: pos.x,
                          y: pos.y,
                          width: GameEngineConstants.defaultPowerupLineDimensions.width,
                          height: GameEngineConstants.defaultPowerupLineDimensions.height)

        let path = CGPath.create(from: rect, centered: true)

        let newPowerupLine = PowerupLine(fiziksBody: PathFiziksBody(path: path,
                                                                    position: pos,
                                                                    affectedByGravity: false,
                                                                    categoryBitMask: PowerupLine.categoryBitMask,
                                                                    collisionBitMask: PowerupLine.collisionBitMask,
                                                                    contactTestBitMask: PowerupLine.contactTestBitMask
                                                                   ), shape: PowerupLineShape(path: path))
        fiziksEngine.add(newPowerupLine.fiziksBody)

        return newPowerupLine
    }

    private func moveCMB(by vector: CGVector) {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        let oldPosition = fiziksBodyToMove.position
        let newPosition = CGPoint(x: oldPosition.x + vector.dx,
                                  y: oldPosition.y + vector.dy)
        fiziksBodyToMove.position = newPosition
    }
}

extension GameEngine: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {

        // check whether it is contact between currently moving block & something else (not level boundaries)
        if let currentBlock = currentlyMovingBlock {
            if contact.contains(body: currentBlock.fiziksBody)
                && !contact.contains(body: leftBoundary)
                && !contact.contains(body: rightBoundary) {
                handlePlaceCMB()
            }

            if currentBlock.isGlueBlock {
                fiziksEngine.combine(bodyA: contact.bodyA, bodyB: contact.bodyB, at: contact.contactPoint)
            }
        }
    }

    func didEnd(_ contact: FiziksContact) {
        // pass
    }

    private func checkAndHandleContactPowerupLine(currentBlock: Block) {
        // landed block in contact with powerup line
        if let powerupLine = powerupLine, currentBlock.fiziksBody.contactTestBitMask == ContactTestMask.block {
            let pos = currentBlock.position
            let height = currentBlock.height

            // if above powerup line & stable (velocity = 0), then give powerup
            if pos.y + height / 2 > powerupLine.position.y
                && pos.y - height / 2 < powerupLine.position.y
                && currentBlock.fiziksBody.velocity == .zero {
                eventManager?.postEvent(BlockTouchedPowerupLineEvent())
                updatePowerupHeight()
            }
        }
    }

    func handlePlaceCMB() {
        // allow gravity and rotation by collisions
        currentlyMovingBlock?.fiziksBody.affectedByGravity = true
        currentlyMovingBlock?.fiziksBody.allowsRotation = true

        // update collsion and contact mask
        currentlyMovingBlock?.fiziksBody.collisionBitMask = Block.collisionBitMask
        currentlyMovingBlock?.fiziksBody.contactTestBitMask = Block.contactTestBitMask

        print("block placed")
        eventManager?.postEvent(BlockPlacedEvent())

        self.currentlyMovingBlock = nil
    }

    /// Returns the y-coordinate of the highest point in the level
    private func findHighestPoint() -> Double {
        var maxY: Double = -.infinity
        gameObjects.forEach({ obj in
            if let block = obj as? Block, block !== currentlyMovingBlock {
                maxY = max(block.position.y + block.height / 2, maxY)
            }
        })

        return maxY
    }
}

// extension to support powerups
extension GameEngine {
    func registerPowerupEvents() {
        eventManager?.registerClosure(for: GluePowerupActivatedEvent.self, closure: { _ in
            self.currentlyMovingBlock?.isGlueBlock = true
        })
        eventManager?.registerClosure(for: PlatformPowerupActivatedEvent.self, closure: { _ in
            guard let newPlatform = self.createPowerupPlatform() else { return }
            self.gameObjects.append(newPlatform)
            print(newPlatform.position)
            self.fiziksEngine.add(newPlatform.fiziksBody)
        })
    }

    // used when platform powerup is activated
    private func createPowerupPlatform() -> Platform? {
        guard let platform = platform else { return nil }
        var count = 0
        while count < GameEngineConstants.defaultTriesToFindPlatformPosition {
            let rngX = Int(rng.next()) % Int(platform.width)
            let newX = CGFloat(rngX) + platform.position.x - platform.width / 2
            var newY = findHighestPoint() + GameEngineConstants.bufferFromHighestPoint
            if let powerupLine = powerupLine {
                newY = min(newY, powerupLine.position.y - GameEngineConstants.defaultPowerupPlatformHeight)
            }
            let newPosition = CGPoint(x: newX, y: newY)
            let rect = CGRect(x: newPosition.x,
                              y: newPosition.y,
                              width: GameEngineConstants.defaultPowerupPlatformWidth,
                              height: GameEngineConstants.defaultPowerupPlatformHeight)
            let path = CGPath.create(from: rect)

            let newPlatform = createPlatform(path: path, at: newPosition)

            let otherBodies = gameObjects.map({ $0.fiziksBody })

            if !fiziksEngine.isIntersecting(body: newPlatform.fiziksBody, otherBodies: otherBodies) {
                return newPlatform
            }

            count += 1
        }

        return nil
    }
}
