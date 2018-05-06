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


class TouchableSKSpriteNode: SKSpriteNode {
    var scoreLabel: SKLabelNode!
    var bubbleType = ""
    weak var delegate: GameSceneDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.calledFromBubble(self)
        self.removeFromParent()
    }
}
