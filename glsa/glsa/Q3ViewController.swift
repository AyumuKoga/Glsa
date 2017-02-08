//
//  Q3ViewController.swift
//  glsa
//
//  Created by 古賀歩 on 2016/11/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit
import SpriteKit

class Q3ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景画像の設定
        let BackgroundImage = UIImage(named: "/Users/ayumu/Desktop/Practice/backgroundimage.png")!
        self.view.backgroundColor = UIColor(patternImage: BackgroundImage)
        
        
        
        func didReceiveMemoryWarning(){
            super.didReceiveMemoryWarning()
            
        }
    }
}
