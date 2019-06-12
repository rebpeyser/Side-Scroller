//
//  GameScene.swift
//  Side Scroller
//
//  Created by Rebecca Peyser on 6/12/19.
//  Copyright © 2019 Rebecca Peyser. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        createPlayer()
        createBackground()
        createGround()
        startRocks()
        }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createPlayer() {
        let playerTexture = SKTexture(imageNamed: "dog-walking0")
        player = SKSpriteNode(texture: playerTexture)
        
        player.zPosition = 10
        player.position = CGPoint(x: frame.width/6, y: frame.height*0.75)
        
        addChild(player)
        
        //Setup the animation of the sprite so it looks like it's running
        let frame2 = SKTexture(imageNamed: "dog-walking1")
        let frame3 = SKTexture(imageNamed: "dog-walking2")
        let animation = SKAction.animate(with: [playerTexture, frame2, frame3, frame2],   timePerFrame: 0.1)
        let runForever = SKAction.repeatForever((animation))
        
        //Run the SKActions on the player sprite
        player.run(runForever)
        
    }
    
    func createBackground() {
        let backgroundTexture = SKTexture(imageNamed: "background")
        for i in 0...1 {
            let background = SKSpriteNode(texture: backgroundTexture)
            background.zPosition = -30
            background.anchorPoint = CGPoint(x: (backgroundTexture.size().width * CGFloat(i)) - CGFloat(1 * i), y: 0)
            addChild(background)
            
            let moveLeft = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: backgroundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            background.run(moveForever)

        }
    }
    
    func createGround(){
        let groundTexture = SKTexture(imageNamed: "ground")
        for i in 0...1 {
            let ground = SKSpriteNode(texture: groundTexture)
            ground.zPosition = -10
            ground.position = CGPoint(x: (groundTexture.size().width/2.0 + (groundTexture.size().width*CGFloat(i))), y: groundTexture.size().height/2)
            addChild(ground)
            
            let moveLeft = SKAction.moveBy(x: -groundTexture.size().width, y: 0, duration: 5)
            let moveReset = SKAction.moveBy(x: groundTexture.size().width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            ground.run(moveForever)
            
        }
    }
    
    func createRocks(){
        let rockTexture = SKTexture(imageNamed: "rock")
        
        let topRock = SKSpriteNode(texture: rockTexture)
        topRock.zPosition = -20
        
        let bottomRock = SKSpriteNode(texture: rockTexture)
        bottomRock.zPosition = -20
        
        addChild(topRock)
        addChild(bottomRock)
        
        let xPosition = frame.width + topRock.frame.width
        let max = CGFloat(frame.height/3)
        let yPosition = CGFloat.random(in: -50...max)
        let rockDistance: CGFloat = 70
        
        topRock.position = CGPoint(x: xPosition, y: yPosition + topRock.size.height*1.5 + rockDistance)
        bottomRock.position = CGPoint(x: xPosition, y: yPosition)
        
        let endPosition = frame.width+(topRock.frame.width*2)
        let moveAction = SKAction.moveBy(x: -endPosition, y: 0, duration: 6)
        let moveSequence = SKAction.sequence([moveAction, SKAction.removeFromParent()])

        
        topRock.run(moveSequence)
        bottomRock.run(moveSequence)

    }
    
    func startRocks(){
        let create = SKAction.run { [unowned self] in
            self.createRocks()
        }
        let wait = SKAction.wait(forDuration: 3)
        let sequence = SKAction.sequence([create,wait])
        let repeatForever = SKAction.repeatForever(sequence)
        run(repeatForever)
    }
    
    
  
}
