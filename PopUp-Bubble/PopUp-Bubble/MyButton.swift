//
//  MyButton.swift
//  UIBUBBLE
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        print("clicked")
        self.removeFromSuperview()
        //        button.isHidden = true
        
        
        
    }
    //}
    @IBAction func increaseCount(button: UIButton) -> Void {
        button.isHidden = true
        
    }
}
