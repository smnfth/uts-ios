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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        super.viewDidLoad()
        
        let button = MyButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .green
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

