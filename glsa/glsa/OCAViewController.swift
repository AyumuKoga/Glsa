//
//  SecondViewController.swift
//  glsa
//
//  Created by 古賀歩 on 2016/11/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation


class OCAViewController: UIViewController{
    
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OCAViewContller Start")
        //背景画像の設定
        let BackgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
        self.view.backgroundColor = BackgroundColor
        
        //スクリーンサイズの取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        //ラベル作る
        //Label生成「補助線を引こう」
        let myLabel_OCA: UILabel = UILabel(frame: CGRect(x: -150,y: -80,width: 1000,height: 50))
        myLabel_OCA.backgroundColor = UIColor.blue
        myLabel_OCA.layer.masksToBounds = true
        myLabel_OCA.layer.cornerRadius = 20.0
        myLabel_OCA.text = "２つの平行線にかかるように補助線を１本引いてみよう"
        myLabel_OCA.textColor = UIColor.white
        myLabel_OCA.font = UIFont.systemFont(ofSize: 36)
        myLabel_OCA.textAlignment = NSTextAlignment.center
        myLabel_OCA.layer.position = CGPoint(x: screenWidth/2,y:screenHeight-700)
        //画面へラベルの追加
        self.view.addSubview(myLabel_OCA)
        //サブクラスの描画
        let ocaDraw = OCADraw(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - 100))
        ocaDraw.backgroundColor = UIColor.clear
        self.view.addSubview(ocaDraw)
        
            //loadView()
            //viewDidLoad()
        
        let nextButton: UIButton = UIButton(frame: CGRect(x: 150,y: 800,width: 120,height: 50))
        nextButton.backgroundColor = UIColor(red: 255/255,green: 129/255,blue: 25/255,alpha: 1.0)
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 + 320 , y:self.view.bounds.height-50)
        nextButton.addTarget(self, action: #selector(onClickNextButton(sender:)), for: .touchUpInside)
        
        let toTopButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 120, height: 50))
        toTopButton.backgroundColor = UIColor(red: 255/255,green: 129/255,blue: 25/255,alpha: 1.0)
        toTopButton.layer.masksToBounds = true
        toTopButton.setTitle("Top", for: .normal)
        toTopButton.layer.cornerRadius = 20.0
        toTopButton.layer.position = CGPoint(x: self.view.bounds.width / 2 - 320, y: self.view.bounds.height - 50)
        toTopButton.addTarget(self, action: #selector(onClicktoTopButton(sender:)), for: .touchUpInside)
        
            
        // ボタンを追加する.
        self.view.addSubview(nextButton)
        self.view.addSubview(toTopButton)
    }
    
    
    internal func onClickNextButton(sender: UIButton){
        let myCircleViewController: UIViewController = CircleViewController()
        myCircleViewController.modalTransitionStyle = .crossDissolve
        self.present(myCircleViewController, animated: true, completion: nil)
    }
    internal func onClicktoTopButton(sender: UIButton){
        let myCircleViewController: UIViewController = StartViewController()
        myCircleViewController.modalTransitionStyle = .crossDissolve
        self.present(myCircleViewController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning(){
            super.didReceiveMemoryWarning()
    }
}
