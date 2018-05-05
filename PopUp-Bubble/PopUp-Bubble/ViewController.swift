//
//  ViewController.swift
//  PopUp-Bubble
//
//  Created by Samaneh Fathieh on 5/5/18.
//  Copyright © 2018 Samaneh Fathieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func bubbleTapped(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bubbleImage = UIImage.init(imageLiteralResourceName: "pink.jpg")
        let bubbleView = UIImageView(image: bubbleImage)
        bubbleView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        let tapHandler = UITapGestureRecognizer(target: self, action: #selector(bubbleTapped(_:)))
        bubbleView.addGestureRecognizer(tapHandler)
        
        self.view.addSubview(bubbleView)
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

