//
//  MenuScene.swift
//  RandomlySpawnEnemyProject
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 SkyVan Labs. All rights reserved.
//

import SpriteKit

protocol MenuSceneDelegate: class {
    func calledFromMenuScene(_ scene: MenuScene)
}

class MenuScene: SKScene {
    var viewController: GameViewController!
    weak var menuDelegate: MenuSceneDelegate?
    var TextInput:UITextField?
    let slider = UISlider(frame: CGRect(x: 10, y: 230, width: 280, height: 20))
    let slider2 = UISlider(frame: CGRect(x: 10, y: 170, width: 280, height: 20))
    let labelSlider = UILabel (frame: CGRect (x: 10, y: 210, width: 280, height: 100))
    let labelSlider2 = UILabel (frame: CGRect (x: 10, y: 190, width: 280, height: 20))
    let textField = UITextField(frame: CGRect(x: 10, y: 280, width: 280, height: 35))
    
    var playerName: String?
    var settings: Settings?
    
    override func didMove(to view: SKView) {
        loadSlider()
        loadTextInput()
        // Set default player name to 'Player1'
        // in case user left the text box blank
        playerName = "Player1"
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches {
            let positionInScene = t.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let name = touchedNode.name
            {
                /*
                 If user touched a node which has the name of
                 startGame, then transit to the other screen (ie. gameScene)
                 */
                if name == "startGame"
                {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let gameSceneTemp =  GameScene(fileNamed: "GameScene") as GameScene?
                    gameSceneTemp?.scaleMode = .aspectFill
                    gameSceneTemp?.settings = settings
                    gameSceneTemp?.playerName = playerName
                    self.scene?.view?.presentScene(gameSceneTemp!, transition: transition)
                    slider.removeFromSuperview()
                    labelSlider.removeFromSuperview()
                    slider2.removeFromSuperview()
                    labelSlider2.removeFromSuperview()
                    textField.removeFromSuperview()
                }
            }
        }
    }
    
    private func loadTextInput() {
        textField.backgroundColor = UIColor.white
        textField.placeholder = "Player1"
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 5
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        textField.addTarget(self, action: #selector(MenuScene.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        view?.addSubview(textField)
    }
    
    @objc private func textFieldDidChange(_ sender:UITextField!){
        playerName = sender.text
    }
    
    private func loadSlider() {
        slider.addTarget(self, action: #selector(MenuScene.slider1ValueDidChange(_:)), for: .valueChanged)
        slider.value = 1
        slider2.addTarget(self, action: #selector(MenuScene.slider2ValueDidChange(_:)), for: .valueChanged)
        slider2.value = 1
        view?.addSubview(slider)
        view?.addSubview(labelSlider)
        view?.addSubview(slider2)
        view?.addSubview(labelSlider2)
    }
    
    
    
    @objc func slider2ValueDidChange(_ sender:UISlider!)
    {
        var time = round(sender.value*60)
        
        // Minimum seconds of the timer is 5 seconds
        if time < 5 {
            time = 5
        }
        settings?.playTime = Double(time)
        labelSlider2.text = String(time)
    }
    /**/
    @objc func slider1ValueDidChange(_ sender:UISlider!)
    {
        let number = round(sender.value*15)
        labelSlider.text = String(number)
        settings?.maxBubbles = Int(number)
    }
    
}
