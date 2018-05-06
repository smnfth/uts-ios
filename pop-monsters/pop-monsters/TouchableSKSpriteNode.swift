//
//  TouchableSKSpriteNode.swift
//  pop-monsters
//
//  Created by Samaneh Fathieh on 6/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate: class {
    func calledFromBubble(_ button: TouchableSKSpriteNode)
}

/*
 This class is to add touchable functionality to SKSpriteNode
 This will be used for the monsters and when user touches a monster
 a delegate (calledFromBubble) will be called.
 This calledFromBubble will be handled in the GameScene.swift file
 */
class TouchableSKSpriteNode: SKSpriteNode {
    var scoreLabel: SKLabelNode!
    var bubbleType = ""
    weak var delegate: GameSceneDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.calledFromBubble(self)
        self.removeFromParent()
    }
}
