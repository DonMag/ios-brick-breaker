//
//  GameScene.swift
//  SuperBrickBreaker
//
//  Created by Shawn Looker on 6/25/16.
//  Copyright (c) 2016 Shawn Looker. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let borderOffset:CGFloat = 45.0
    let blockWidth:CGFloat = 90.0
    let blockHeight:CGFloat = 45.0
    var touchLocation:CGPoint = CGPointZero
    let firstRowY:CGFloat = 960.0
    
    let bouncerMoveSpeed:CGFloat = 10.0
    
    var bouncer: SKSpriteNode!
    var ball: SKSpriteNode!
    
    var bouncerMovement: Movement = .Stopped

    let wallMask = 0x1 << 0
    let blockMask = 0x1 << 2
    let bouncerMask = 0x1 << 3
    let ballMask = 0x1 << 4
    
    enum Movement {
        case Left
        case Right
        case Stopped
    }
    
    override func didMoveToView(view: SKView) {
        print("in gamescene")
        
        bouncer = self.childNodeWithName("bouncer") as! SKSpriteNode
        
        // Add ball
        ball =  SKScene(fileNamed: "Ball")!.childNodeWithName("Ball")! as! SKSpriteNode
        ball.removeFromParent()
        ball.position = CGPoint(x: 120.0, y: 120.0)
        self.addChild(ball)

        
        print("Bouncer X: \(bouncer.position.x)")
        
        
        for i in 0...10 {
            for j in 0...6 {
                let block:SKSpriteNode = SKScene(fileNamed: "Block")!.childNodeWithName("Block")! as! SKSpriteNode
                block.removeFromParent()
                block.color = UIColor.blueColor()
                let x:CGFloat = borderOffset + CGFloat(i) * blockWidth
                let y:CGFloat = firstRowY + borderOffset + CGFloat(j) * blockHeight
                block.position = CGPoint(x: x, y: y)
                self.addChild(block)
            }
            
        }
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("touch began in GameScene")
        /* Called when a touch begins */
        touchLocation = touches.first!.locationInNode(self)
        if touchLocation.x <= size.width / 2.0 {
//            print("Changing movement to left")
            bouncerMovement = .Left
        }
        if touchLocation.x > size.width / 2.0 {
//            print("Changing movement to right")
            bouncerMovement = .Right
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("Stopping movement")
        bouncerMovement = .Stopped
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchLocation = touches.first!.locationInNode(self)
    }
    
    override func update(currentTime: CFTimeInterval) {
//        print("Bouncer movement: \(bouncerMovement)")
        if bouncerMovement == Movement.Left {
            if bouncer.position.x - bouncerMoveSpeed > borderOffset {
//                print("Starting X: \(bouncer.position.x)")
                bouncer.position.x -= bouncerMoveSpeed
//                print("Ending X: \(bouncer.position.x)")
            } else {
//                print("Stuck at border")
                bouncer.position.x = borderOffset
            }
//            print("Moving left: \(bouncer.position.x)")
        } else if bouncerMovement == Movement.Right {
            if bouncer.position.x + bouncerMoveSpeed + bouncer.size.width < size.width - borderOffset {
                bouncer.position.x = bouncer.position.x + bouncerMoveSpeed
            } else {
                bouncer.position.x = size.width - borderOffset - bouncer.size.width
            }
//            print("Moving right")
        } else {
//            print("Not moving")
        }
        /* Called before each frame is rendered */
    }
}
