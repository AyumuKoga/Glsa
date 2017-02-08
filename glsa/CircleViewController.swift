//
//  CircleViewController.swift
//  glsa
//
//  Created by 古賀歩 on 2016/12/02.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class CircleViewController: UIViewController{
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
        
        print("CirleViewController start")
        
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        //Label生成「どの色の角同士が等しくなるかな？」
        let myLabel_Cdraw: UILabel = UILabel(frame: CGRect(x: -150,y: -80,width: 1000,height: 50))
        myLabel_Cdraw.backgroundColor = UIColor.magenta
        myLabel_Cdraw.layer.masksToBounds = true
        myLabel_Cdraw.layer.cornerRadius = 20.0
        myLabel_Cdraw.text = "どの色の角同士が等しくなるかな？"
        myLabel_Cdraw.textColor = UIColor.white
        myLabel_Cdraw.font = UIFont.systemFont(ofSize: 36)
        myLabel_Cdraw.textAlignment = NSTextAlignment.center
        myLabel_Cdraw.layer.position = CGPoint(x: self.view.bounds.width/2,y:self.view.bounds.height-700)
        //画面へラベルの追加
        self.view.addSubview(myLabel_Cdraw)

        
        
        let drawcircleview = drawCircleView(frame: CGRect(x: 0, y:0, width: screenWidth, height: screenHeight))
        drawcircleview.backgroundColor = UIColor.clear
        self.view.addSubview(drawcircleview)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
