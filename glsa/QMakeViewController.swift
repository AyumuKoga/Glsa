//
//  QMakeViewController.swift
//  glsa
//
//  Created by 古賀歩 on 2016/12/06.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class QMakeViewController: UIViewController{
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var canvas = UIImageView()
    var bezierPath:UIBezierPath!
    var lastDrawImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
        
        print("CirleViewController start")
        print(self.delegate.InterSectionPoints1!)
        print(self.delegate.InterSectionPoints2!)
        
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        
        canvas.frame = CGRect(x:0,y:0,width:screenWidth,height:screenHeight)
        canvas.backgroundColor = UIColor.clear
        view.addSubview(canvas)
        
        
        let arc = UIBezierPath(arcCenter: delegate.InterSectionPoints1!, radius: 30, startAngle: 0, endAngle: 90, clockwise: true)
        let acolor = UIColor.yellow
        acolor.setStroke()
        arc.lineWidth = 10
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touches.first!.location(in: canvas)
        bezierPath = UIBezierPath()
        bezierPath.lineWidth = 4.0
        bezierPath.move(to: currentPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil{
            return
        }
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: canvas)
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
        lastDrawImage = canvas.image!
    }
    
    func drawLine(path:UIBezierPath){
        UIGraphicsBeginImageContext(canvas.frame.size)
        if lastDrawImage != nil{
            lastDrawImage.draw(at: CGPoint.zero)
        }
        let lineColor = UIColor.yellow
        lineColor.setStroke()
        path.stroke()
        canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

