//
//  GameScene.swift
//  pop-monsters
//
//  Created by Samaneh Fathieh on 6/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, GameSceneDelegate {
    
    var playerName: String?
    var settings: Settings?
    var scoreLabel: SKLabelNode!
    var timerLbl: SKLabelNode!
    var lastUpdateTime: TimeInterval = 0
    
    var maxNumberOfBubbles = 15
    //random logic
    var delay: TimeInterval = 0.5
    var timeSinceStart: TimeInterval = 0.0
    
    var lastColor = ""
    var score: Double = 0
    
    var countdownTimer: Timer!
    var totalTime:Double = 4
    var TimeInterval = 1
    
    let timerLabel = UILabel (frame: CGRect (x: 10, y: 130, width: 280, height: 20))
    
    //MARK: - Scene Stuff
    override func didMove(to view: SKView) {
        monsterSpawner(delay: 0.5)
        
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text="0"
        
        timerLbl = childNode(withName: "timerLbl") as! SKLabelNode
        timerLbl.text=""
        totalTime = (settings?.playTime)!
        maxNumberOfBubbles = (settings?.maxBubbles)!
        startTimer()
    }
    
    
    @objc func updateTime() {
        timerLbl.text = "\(timeFormatted(Int(totalTime)))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let sceneTemp =  FinishScene(fileNamed: "FinishScene") as FinishScene?
        sceneTemp?.scaleMode = .aspectFill
        sceneTemp?.playerName = self.playerName
        sceneTemp?.score = self.score
        sceneTemp?.settings = self.settings
        self.scene?.view?.presentScene(sceneTemp!, transition: transition)
        timerLbl.removeFromParent()
        
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func monsterSpawner(delay: TimeInterval){
        removeAction(forKey: "spawnMonsters")
        
        self.delay = delay
        
        let delayAction = SKAction.wait(forDuration: delay)
        let spawnAction = SKAction.run {
            self.spawnMonster()
        }
        
        let sequenceAction = SKAction.sequence([delayAction, spawnAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        run(repeatAction, withKey: "spawnMonsters")
    }
    
    func checkValidLocation(_ newBubble: SKSpriteNode) -> Bool {
        for subview in (self.children) {
            if let existingBubble = subview as? SKSpriteNode {
                if existingBubble.frame.intersects(newBubble.frame) {
                    return false
                }
            }
        }
        return true
    }
    
    func spawnMonster(){
        if(self.children.count > maxNumberOfBubbles + 1) {
            return
        }
        //size
        var monsterSize = CGSize(width: 100, height: 70)
        
        let randomSize = arc4random() % 3
        
        switch randomSize {
        case 1:
            monsterSize.width *= 1.2
            monsterSize.height *= 1.2
        case 2:
            monsterSize.width *= 1.5
            monsterSize.height *= 1.5
        default:
            break
        }
        
        //position
        let y = size.height/2+monsterSize.height/2
        let cSpots = [-1*(size.width/2-monsterSize.width/2)
            ,-1*(size.width/4-monsterSize.width/2)
            ,0
            ,size.width/4-monsterSize.width/2
            ,size.width/2-monsterSize.width/2]
        let randomX = cSpots[Int(arc4random() % 5)]
        let colors = ["black", "blue", "blue", "green", "green", "green", "purple", "purple", "purple", "purple", "purple", "purple", "red", "red", "red", "red", "red", "red", "red", "red"];
        let randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
        let color = colors[randomIndex]
        
        //init
        let monster = TouchableSKSpriteNode(imageNamed: color)
        monster.size = CGSize(width: 100.0,height: 100.0)
        monster.isUserInteractionEnabled = true
        monster.position = CGPoint(x: randomX, y: y)
        monster.bubbleType = color
        monster.delegate = self
        if checkValidLocation(monster) {
            addChild(monster)
        }
        
        //move
        let moveDownAction = SKAction.moveBy(x: 0, y: -size.height-monster.size.height, duration: 20.0)
        let destroyAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([moveDownAction, destroyAction])
        monster.run(sequenceAction)
        
        //rotation
        var rotateAction = SKAction.rotate(byAngle: 1, duration: 1)
        
        let randomRotation = arc4random() % 2
        
        if randomRotation == 1  {
            rotateAction = SKAction.rotate(byAngle: -1, duration: 1)
        }
        
        let repeatForeverAction = SKAction.repeatForever(rotateAction)
        if arc4random() % 5 != 0 {
            monster.run(repeatForeverAction)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastUpdateTime == 0 {
            lastUpdateTime = currentTime
            return
        }
        
        let dt = currentTime - lastUpdateTime
        
        //difficulty
        timeSinceStart += dt
        
        if timeSinceStart > 5 && delay > 0.4 {
            print("0.4")
            monsterSpawner(delay: 0.4)
        } else if timeSinceStart > 10 && delay > 0.3 {
            print("0.1")
            monsterSpawner(delay: 0.1)
        }
        
        lastUpdateTime = currentTime
    }
    
    func calledFromBubble(_ button: TouchableSKSpriteNode) {
        var point: Double = 0;
        if button.bubbleType == "red" {
            point = 1
        }
        if button.bubbleType == "purple" {
            point = 2
        }
        if button.bubbleType == "green" {
            point = 5
        }
        if button.bubbleType == "blue" {
            point = 8
        }
        if button.bubbleType == "black" {
            point = 10
        }
        
        if lastColor == button.bubbleType {
            point *= 1.5
        }
        lastColor = button.bubbleType
        score += point;
        scoreLabel.text = String(score)
    }
}
