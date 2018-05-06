//
//  GameViewController.swift
//  pop-monsters
//
//  Created by Samaneh Fathieh on 6/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

struct Settings {
    var maxBubbles: Int
    var playTime: Double
    init(maxBubbles: Int, playTime: Double) {
        self.maxBubbles = maxBubbles
        self.playTime = playTime
    }
}

class GameViewController: UIViewController, MenuSceneDelegate {
    func calledFromMenuScene(_ scene: MenuScene) {
        print("calledFromMenuScene")
    }
    var playerName: String?
    var settings: Settings?
    @IBOutlet weak var timerLabel: UILabel!
    
    var countdownTimer: Timer!
    var totalTime = 60
    var TimeInterval = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            //             Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "FinishScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//                // Present the scene
//                view.presentScene(scene)
//                return
//            }
            
            if let scene = SKScene(fileNamed: "MenuScene") as? MenuScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.settings =  Settings(maxBubbles:15, playTime: 60 )
                scene.playerName = self.playerName
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
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
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "FinishScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
        timerLabel.removeFromSuperview()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.destination as? GameViewController {
            scene.playerName = "..."
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
