//
//  ViewController.swift
//  PopUp-Bubble
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func bubbleTapped(sender: UIButton) {
        sender.isHidden = true
    }
    
    func setTimeout(_ delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
    let probablities = [UIColor.black, UIColor.blue, UIColor.blue, UIColor.green, UIColor.green, UIColor.green, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.purple, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red, UIColor.red];
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        super.viewDidLoad()
        
        
        let x = CGFloat(arc4random_uniform(UInt32(self.view.frame.width-100)) + 1);
        let y = CGFloat(arc4random_uniform(UInt32(self.view.frame.height-100)) + 1);
        
        //        let button = MyButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        //        let randomX = CGFloat(randomSource.nextUniform()) * (self.view.frame.width-100)
        //        let randomY = CGFloat(randomSource.nextUniform()) * (self.view.frame.height-100)
        let button = MyButton(frame: CGRect(x: x, y: y, width: 100, height: 100))
        
//        button.backgroundColor = .green
        let randomIndex = Int(arc4random_uniform(UInt32(probablities.count)))
        button.backgroundColor = probablities[randomIndex]
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        
    }
    
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

