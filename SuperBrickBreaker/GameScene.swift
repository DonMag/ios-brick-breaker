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
    
	var leftBounds:CGFloat = 0.0
	var rightBounds:CGFloat = 0.0
	
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
        ball.position = CGPoint(x: 120.0, y: 200.0)
        self.addChild(ball)

        for i in 0...10 {
            for j in 0...6 {
//				let block:SKSpriteNode = SKScene(fileNamed: "Block")!.childNodeWithName("Block")! as! SKSpriteNode
				let block:SKSpriteNode = SKScene(fileNamed: "Block2")!.childNodeWithName("Block2")! as! SKSpriteNode
                block.removeFromParent()
                block.color = UIColor.blueColor()
                let x:CGFloat = borderOffset + CGFloat(i) * blockWidth + (blockWidth / 2)
                let y:CGFloat = firstRowY + borderOffset + CGFloat(j) * blockHeight
                block.position = CGPoint(x: x, y: y)
                self.addChild(block)
            }
            
        }
        /* Setup your scene here */
		
		bouncer.position.x = size.width / 2
		bouncer.position.y = 100
		
		leftBounds = borderOffset + (bouncer.size.width / 2.0)
		rightBounds = size.width - (borderOffset + (bouncer.size.width / 2))
		

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
		
		let x = (bouncer.position.x)
		let y = (bouncer.position.y)
		let sp = (bouncerMoveSpeed)
		let b = (borderOffset)
		
        if bouncerMovement == Movement.Left {
			
			print("L x \(x) : \(y) - sp \(sp) - b \(b)")
			
			bouncer.position.x -= bouncerMoveSpeed
			
			if bouncer.position.x < leftBounds {
				bouncer.position.x = leftBounds
			}
			

//            if bouncer.position.x - bouncerMoveSpeed > borderOffset {
//                print("Starting X: \(bouncer.position.x)")
//                bouncer.position.x -= bouncerMoveSpeed
//                print("Ending X: \(bouncer.position.x)")
//            } else {
//                print("Stuck at border")
//                bouncer.position.x = borderOffset
//            }

		} else if bouncerMovement == Movement.Right {
			
			print("R x \(x) : \(y) - sp \(sp) - b \(b)")
			
			bouncer.position.x += bouncerMoveSpeed
			
			if bouncer.position.x > rightBounds {
				bouncer.position.x = rightBounds
			}
			
//            if bouncer.position.x + bouncerMoveSpeed + bouncer.size.width < size.width - borderOffset {
//                bouncer.position.x = bouncer.position.x + bouncerMoveSpeed
//            } else {
//                bouncer.position.x = size.width - borderOffset - bouncer.size.width
//            }
//            print("Moving right")
        } else {
//			print("C x \(x) : \(y) - sp \(sp) - b \(b)")
//            print("Not moving")
        }
        /* Called before each frame is rendered */
    }
}
