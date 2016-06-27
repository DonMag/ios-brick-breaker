//
//  MainMenu.swift
//  SuperBrickBreaker
//
//  Created by Shawn Looker on 6/25/16.
//  Copyright © 2016 Shawn Looker. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    override func didMoveToView(view: SKView) {
        print("in main menu \(self.debugDescription)")
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("main menu touch")
		let game:GameScene = GameScene(fileNamed: "GameScene")!
		game.scaleMode = .AspectFill
		game.scaleMode = .AspectFit
        let transition:SKTransition = SKTransition.crossFadeWithDuration(1.0)
        self.view?.presentScene(game, transition: transition)
    }
}
