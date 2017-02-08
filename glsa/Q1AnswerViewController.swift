//
//  Q1AnswerViewController.swift
//  glsa
//
//  Created by 古賀歩 on 2017/02/03.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Q1AnswerViewController: UIViewController {
    
    var q1ansdraw = Q1AnsDraw()
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var lastDrawImage: UIImage!
    var Canvas = UIImageView()
    var SetOrNot:Bool = false
    var FstSec:String!
    var SecSec:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Q1Answer Start")
        
        //背景画像の設定
        let BackgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
        self.view.backgroundColor = BackgroundColor
        
        //スクリーンサイズの取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        //ラベル生成
        let Label_Q1Ans:UILabel = UILabel(frame: CGRect(x: -150, y: -80, width: 1000, height: 50))
        Label_Q1Ans.backgroundColor = UIColor.gray
        Label_Q1Ans.layer.masksToBounds = true
        Label_Q1Ans.layer.cornerRadius = 20.0
        Label_Q1Ans.text = "OK!では、角Xはどうなる？"
        Label_Q1Ans.textColor = UIColor.white
        Label_Q1Ans.font = UIFont.systemFont(ofSize: 36)
        Label_Q1Ans.textAlignment = NSTextAlignment.center
        Label_Q1Ans.layer.position = CGPoint(x: screenWidth/2, y: screenHeight - 700)
        
        //角度Xラベルの生成
        let Label_XAns:UILabel = UILabel(frame: CGRect(x: 200, y: 200, width: 300, height: 50))
        Label_XAns.backgroundColor = UIColor.clear
        Label_XAns.layer.masksToBounds = true
        Label_XAns.text = "X"
        Label_XAns.textColor = UIColor.orange
        Label_XAns.font = UIFont.systemFont(ofSize: 45)
        Label_XAns.textAlignment = NSTextAlignment.center
        Label_XAns.layer.position = CGPoint(x: screenWidth/2 + 30, y: screenHeight / 2 - 10)
        //角度αラベルの生成
        let Label_alphaAns:UILabel = UILabel(frame: CGRect(x: 200, y: 200, width: 300, height: 50))
        Label_alphaAns.backgroundColor = UIColor.clear
        Label_alphaAns.layer.masksToBounds = true
        Label_alphaAns.text = "α"
        Label_alphaAns.textColor = UIColor.orange
        Label_alphaAns.font = UIFont.systemFont(ofSize: 40)
        Label_alphaAns.textAlignment = NSTextAlignment.center
        Label_alphaAns.layer.position = CGPoint(x: 500, y: 280)
        //角度βラベルの生成
        let Label_betaAns:UILabel = UILabel(frame: CGRect(x: 200, y: 200, width: 300, height: 50))
        Label_betaAns.backgroundColor = UIColor.clear
        Label_betaAns.layer.masksToBounds = true
        Label_betaAns.text = "β"
        Label_betaAns.textColor = UIColor.orange
        Label_betaAns.font = UIFont.systemFont(ofSize: 40)
        Label_betaAns.textAlignment = NSTextAlignment.center
        Label_betaAns.layer.position = CGPoint(x: 725, y: 580)
        //画面へラベルを追加
        self.view.addSubview(Label_Q1Ans)
        self.view.addSubview(Label_XAns)
        self.view.addSubview(Label_alphaAns)
        self.view.addSubview(Label_betaAns)

        q1ansdraw = Q1AnsDraw(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        q1ansdraw.backgroundColor = UIColor.clear
        self.view.addSubview(q1ansdraw)

        Canvas.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        Canvas.backgroundColor = UIColor.clear
        view.addSubview(Canvas)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.view)

        //print(currentPoint)
        if SetOrNot == false {
            let touchSectorFirst:String = q1ansdraw.getTouchSector(TouchPoint: currentPoint)
            FstSec = touchSectorFirst
            setStrokeColor(selectSector: touchSectorFirst)
            print(touchSectorFirst)
            SetOrNot = true
        }else{
            let touchSectorSecond:String = q1ansdraw.getTouchSector(TouchPoint: currentPoint)
            SecSec = touchSectorSecond
            print(touchSectorSecond)
            judgeAndChangeColorSector(FirstSector: FstSec, SecondSector: SecSec)
            lastDrawImage = Canvas.image!
            clearStrokeColor()
            SetOrNot = false
        }
        
    }
    
    func setStrokeColor(selectSector:String){
        UIGraphicsBeginImageContext(Canvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint.zero)
        }
        let StrokeColor = UIColor.black
        StrokeColor.setStroke()
        
        switch selectSector {
        case "Alpha":
            let arcALPHA = delegate.q1arcAlpha
            arcALPHA?.stroke()
        case "Beta":
            let arcBETA = delegate.q1arcBeta
            arcBETA?.stroke()
        case "XUpside":
            let arcXup = delegate.q1XSectorUpside
            arcXup?.lineWidth = 7
            arcXup?.stroke()
        case "XDownside":
            let arcXdown = delegate.q1XSectorDownside
            arcXdown?.lineWidth = 7
            arcXdown?.stroke()
        default: break
        }
        

        self.Canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func judgeAndChangeColorSector(FirstSector: String, SecondSector: String){
        UIGraphicsBeginImageContext(Canvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint.zero)
        }
        if FirstSector == "Alpha" && SecondSector == "XUpside"{
            let arcXupside = delegate.q1XSectorUpside
            UIColor.red.setFill()
            arcXupside?.fill()
            arcXupside?.lineWidth = 5
            UIColor.white.setStroke()
            arcXupside?.stroke()
        }
        if FirstSector == "XUpside" && SecondSector == "Alpha" {
            let arcXupside = delegate.q1XSectorUpside
            UIColor.red.setFill()
            arcXupside?.fill()
            arcXupside?.lineWidth = 5
            UIColor.white.setStroke()
            arcXupside?.stroke()
        }
        if FirstSector == "Beta" && SecondSector == "XDownside" {
            let arcXdownside = delegate.q1XSectorDownside
            UIColor.green.setFill()
            arcXdownside?.fill()
            arcXdownside?.lineWidth = 5
            UIColor.white.setStroke()
            arcXdownside?.stroke()
        }
        if FirstSector == "XDownside" && SecondSector == "Beta" {
            let arcXdownside = delegate.q1XSectorDownside
            UIColor.green.setFill()
            arcXdownside?.fill()
            arcXdownside?.lineWidth = 5
            UIColor.white.setStroke()
            arcXdownside?.stroke()
        }
        
        self.Canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

    }
    
    func clearStrokeColor(){
        UIGraphicsBeginImageContext(Canvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint.zero)
        }
        let StrokeColor = UIColor.white
        let arcALPHA = delegate.q1arcAlpha
        let arcBETA = delegate.q1arcBeta
        let arcX = delegate.q1arcX
        StrokeColor.setStroke()
        arcALPHA?.stroke()
        arcBETA?.stroke()
        arcX?.stroke()
        self.Canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
