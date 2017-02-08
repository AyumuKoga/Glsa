//
//  StartViewController.swift
//  glsa
//
//  Created by 古賀歩 on 2016/11/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景の設定
        
        let BackgroundColor = UIColor(red: 0, green: 0.392, blue: 0, alpha: 1.0)
        self.view.backgroundColor = BackgroundColor
 
        /*---------------------------------------------------------------------------------------------*/
        /*--------------------------------------基礎編のボタンとラベル-------------------------------------*/
        //Label生成「基礎編：等しくなる角は？」
        let myLabel_kiso: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 500,height: 35))
        myLabel_kiso.backgroundColor = UIColor.clear
        myLabel_kiso.layer.masksToBounds = true
        myLabel_kiso.text = "基礎編：等しくなる角は？"
        myLabel_kiso.textColor = UIColor.white
        myLabel_kiso.font = UIFont.systemFont(ofSize: 36)
        myLabel_kiso.textAlignment = NSTextAlignment.center
        myLabel_kiso.layer.position = CGPoint(x: self.view.bounds.width/2,y:self.view.bounds.height-650)
        //画面へラベルの追加
        self.view.addSubview(myLabel_kiso)
        
        //画面遷移ボタン 等しくなる角は？　遷移先　ー＞　対頂角・同位角・錯角
        let nextButton_OCA: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 500,height:50))
        nextButton_OCA.setTitleColor(UIColor.yellow, for: .normal)
        nextButton_OCA.backgroundColor = UIColor.brown
        nextButton_OCA.layer.masksToBounds = true
        nextButton_OCA.setTitle("対頂角・同位角・錯角", for: .normal)
        nextButton_OCA.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        nextButton_OCA.layer.cornerRadius = 15.0
        nextButton_OCA.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-600)
        nextButton_OCA.addTarget(self, action: #selector(StartViewController.onClickMyButtonOCA(_:)), for: .touchUpInside)
        //画面へボタンの追加
        self.view.addSubview(nextButton_OCA)
        
        
        /*-------------------------------------ここまでが基礎編の-------------------------------------------*/
        /*-----------------------------------------------------------------------------------------------*/
        /*-------------------------------------ここから実践編のボタン----------------------------------------*/
        
        //Label生成「実践編：問題を解いてみよう」
        let myLabel_q1: UILabel = UILabel(frame: CGRect(x: 0,y: 0,width: 600,height: 35))
        myLabel_q1.backgroundColor = UIColor.clear
        myLabel_q1.layer.masksToBounds = true
        myLabel_q1.text = "実践編：問題を解いてみよう"
        myLabel_q1.textColor = UIColor.white
        myLabel_q1.font = UIFont.systemFont(ofSize: 36)
        myLabel_q1.textAlignment = NSTextAlignment.center
        myLabel_q1.layer.position = CGPoint(x: self.view.bounds.width/2,y:self.view.bounds.height-500)
        //画面へラベルの追加
        self.view.addSubview(myLabel_q1)
        
        //画面遷移その1ボタン 問題を解いてみよう？　遷移先　ー＞　同位角・対頂角・錯角を利用した問題１
        let nextButton_q1: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 130,height:60))
        nextButton_q1.setTitleColor(UIColor.yellow, for: .normal)
        nextButton_q1.backgroundColor = UIColor.brown
        nextButton_q1.layer.masksToBounds = true
        nextButton_q1.setTitle("問題１", for: .normal)
        nextButton_q1.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        nextButton_q1.layer.cornerRadius = 15.0
        nextButton_q1.layer.position = CGPoint(x: self.view.bounds.width-700 , y:self.view.bounds.height-440)
        nextButton_q1.addTarget(self, action: #selector(StartViewController.onClickMyButton_q1(_:)), for: .touchUpInside)
        //画面へボタンの追加
        self.view.addSubview(nextButton_q1)
        
        //画面遷移その2ボタン 問題を解いてみよう？　遷移先　ー＞　同位角・対頂角・錯角を利用した問題２
        let nextButton_q2: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 130,height:60))
        nextButton_q2.setTitleColor(UIColor.yellow, for: .normal)
        nextButton_q2.backgroundColor = UIColor.brown
        nextButton_q2.layer.masksToBounds = true
        nextButton_q2.setTitle("問題2", for: .normal)
        nextButton_q2.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        nextButton_q2.layer.cornerRadius = 15.0
        nextButton_q2.layer.position = CGPoint(x: self.view.bounds.width-510 , y:self.view.bounds.height-440)
        nextButton_q2.addTarget(self, action: #selector(StartViewController.onClickMyButton_q2(_:)), for: .touchUpInside)
        //画面へボタンの追加
        self.view.addSubview(nextButton_q2)
        
        //画面遷移その3ボタン 問題を解いてみよう？　遷移先　ー＞　同位角・対頂角・錯角を利用した問題3
        let nextButton_q3: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 130,height:60))
        nextButton_q3.setTitleColor(UIColor.yellow, for: .normal)
        nextButton_q3.backgroundColor = UIColor.brown
        nextButton_q3.layer.masksToBounds = true
        nextButton_q3.setTitle("問題3", for: .normal)
        nextButton_q3.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        nextButton_q3.layer.cornerRadius = 15.0
        nextButton_q3.layer.position = CGPoint(x: self.view.bounds.width-320 , y:self.view.bounds.height-440)
        nextButton_q3.addTarget(self, action: #selector(StartViewController.onClickMyButton_q3(_:)), for: .touchUpInside)
        //画面へボタンの追加
        self.view.addSubview(nextButton_q3)
        
        
        //画面遷移 作図の練習
        let nextButton_prcConstruction: UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: 500,height:60))
        nextButton_prcConstruction.setTitleColor(UIColor.yellow, for: .normal)
        nextButton_prcConstruction.backgroundColor = UIColor.brown
        nextButton_prcConstruction.layer.masksToBounds = true
        nextButton_prcConstruction.setTitle("作図の練習", for: .normal)
        nextButton_prcConstruction.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        nextButton_prcConstruction.layer.cornerRadius = 15.0
        nextButton_prcConstruction.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-300)
        nextButton_prcConstruction.addTarget(self, action: #selector(StartViewController.onClickMyButton_prcConstruction(_:)), for: .touchUpInside)
        //画面へボタンの追加
        self.view.addSubview(nextButton_prcConstruction)
        
        //画面遷移　作図モード
        let nextButton_Construction: UIButton = UIButton(frame: CGRect(x:0, y:0, width:500, height:60))
        nextButton_Construction.setTitleColor(UIColor.yellow, for: .normal)
        nextButton_Construction.backgroundColor = UIColor.brown
        nextButton_Construction.layer.masksToBounds = true
        nextButton_Construction.setTitle("作図モード", for: .normal)
        nextButton_Construction.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        nextButton_Construction.layer.cornerRadius = 15.0
        nextButton_Construction.layer.position = CGPoint(x:self.view.bounds.width/2, y:self.view.bounds.height - 200)
        nextButton_Construction.addTarget(self, action: #selector(StartViewController.onClickMyButton_Construction(_:)), for: .touchUpInside)
        //画面へボタン追加
        self.view.addSubview(nextButton_Construction)
        
    }
    /*---------------------------------------------------------------------------------------------*/
    /*--------------------------------------Button       Event-------------------------------------*/
    /*---------------------------------------------------------------------------------------------*/
    
    internal func onClickMyButtonOCA(_ sender: UIButton){
        
        //遷移するViewを定義する
        let mySecondViewController: UIViewController = OCAViewController()
        
        //アニメーションの設定
        mySecondViewController.modalTransitionStyle = .crossDissolve
        
        //Viewの移動
        self.present(mySecondViewController, animated: true, completion: nil)
    }
    
    
    internal func onClickMyButton_q1(_ sender: UIButton){
        
        //遷移するViewを定義する
        let mySecondViewController: UIViewController = Q1ViewController()
        
        //アニメーションの設定
        mySecondViewController.modalTransitionStyle = .crossDissolve
        
        //Viewの移動
        self.present(mySecondViewController, animated: true, completion: nil)
    }
    
    internal func onClickMyButton_q2(_ sender: UIButton){
        
        //遷移するViewを定義する
        //let mySecondViewController: UIViewController = ViewControllerGesture() これは単なる練習用。無視して良い、
        let mySecondViewController: UIViewController = Q2ViewController()
        
        //アニメーションの設定
        mySecondViewController.modalTransitionStyle = .crossDissolve
        
        //Viewの移動
        self.present(mySecondViewController, animated: true, completion: nil)
    }
    
    internal func onClickMyButton_q3(_ sender: UIButton){
        
        //遷移するViewを定義する
        let mySecondViewController: UIViewController = Q3ViewController()
        
        //アニメーションの設定
        mySecondViewController.modalTransitionStyle = .crossDissolve
        
        //Viewの移動
        self.present(mySecondViewController, animated: true, completion: nil)
    }
    
    internal func onClickMyButton_prcConstruction(_ sender: UIButton){
        
        let mySecondViewController: UIViewController = QMakeViewController()
        
        //アニメーションの設定
        mySecondViewController.modalTransitionStyle = .crossDissolve
        
        //Viewの移動
        self.present(mySecondViewController, animated: true, completion: nil)
        
    }
    
    internal func onClickMyButton_Construction(_ sender: UIButton){
        
        let mySecondViewController: UIViewController = ConstructionViewController()
        
        mySecondViewController.modalTransitionStyle = .crossDissolve
        
        self.present(mySecondViewController, animated: true,completion: nil)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning(){
            super.didReceiveMemoryWarning()

    }
    
    
}
