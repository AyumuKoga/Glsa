//
//  Q1ViewController.swift
//  glsa
//
//  Created by 古賀歩 on 2016/11/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class Q1ViewController: UIViewController{
    
    var XLine = UIBezierPath()
    var preParallelLine = UIBezierPath()
    var lastDrawImage: UIImage!
    var ExtensionLineCanvas = UIImageView()
    var ParallelSymbolCanvas = UIImageView()
    
    var AccurateExtensionLine = UIBezierPath()//直線用のベジェ曲線
    var AccurateParallelLine = UIBezierPath()//平行記号用のベジェ曲線
    var XlineStartPoint = CGPoint()//補助線のスタートポイント
    var XlineEndPoint = CGPoint()//補助線のエンドポイント
    var parallelSymbolStartPoint = CGPoint()
    var parallelSymbolEndPoint = CGPoint()
    var parallelSymbolInetrSectionPoint = CGPoint()
    var IntersectionJudge:Bool = false
    var ExtensionLineDraw:Bool = false//補助線が引かれたかブール
    //計算用のクラスインスタンス
    var geometrycalculation = GeometryCalculation()
    //send_deligate_var
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Q1ViewController Start")
        
        //背景画像の設定
        let BackgroundColor = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1.0)
        self.view.backgroundColor = BackgroundColor
        
        //スクリーンサイズの取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height

        
        //ラベル生成
        let Label_Q1:UILabel = UILabel(frame: CGRect(x: -150, y: -80, width: 1000, height: 50))
        Label_Q1.backgroundColor = UIColor.gray
        Label_Q1.layer.masksToBounds = true
        Label_Q1.layer.cornerRadius = 20.0
        Label_Q1.text = "角Xを求めるために、補助線を引くとしたら？"
        Label_Q1.textColor = UIColor.white
        Label_Q1.font = UIFont.systemFont(ofSize: 36)
        Label_Q1.textAlignment = NSTextAlignment.center
        Label_Q1.layer.position = CGPoint(x: screenWidth/2, y: screenHeight - 700)
    
        //角度Xラベルの生成
        let Label_X:UILabel = UILabel(frame: CGRect(x: 200, y: 200, width: 300, height: 50))
        Label_X.backgroundColor = UIColor.clear
        Label_X.layer.masksToBounds = true
        Label_X.text = "X"
        Label_X.textColor = UIColor.orange
        Label_X.font = UIFont.systemFont(ofSize: 45)
        Label_X.textAlignment = NSTextAlignment.center
        Label_X.layer.position = CGPoint(x: screenWidth/2 + 30, y: screenHeight / 2 - 10)
        //角度αラベルの生成
        let Label_alpha:UILabel = UILabel(frame: CGRect(x: 200, y: 200, width: 300, height: 50))
        Label_alpha.backgroundColor = UIColor.clear
        Label_alpha.layer.masksToBounds = true
        Label_alpha.text = "α"
        Label_alpha.textColor = UIColor.orange
        Label_alpha.font = UIFont.systemFont(ofSize: 40)
        Label_alpha.textAlignment = NSTextAlignment.center
        Label_alpha.layer.position = CGPoint(x: 500, y: 280)
        //角度βラベルの生成
        let Label_beta:UILabel = UILabel(frame: CGRect(x: 200, y: 200, width: 300, height: 50))
        Label_beta.backgroundColor = UIColor.clear
        Label_beta.layer.masksToBounds = true
        Label_beta.text = "β"
        Label_beta.textColor = UIColor.orange
        Label_beta.font = UIFont.systemFont(ofSize: 40)
        Label_beta.textAlignment = NSTextAlignment.center
        Label_beta.layer.position = CGPoint(x: 725, y: 580)
        //画面へラベルを追加
        self.view.addSubview(Label_Q1)
        self.view.addSubview(Label_X)
        self.view.addSubview(Label_alpha)
        self.view.addSubview(Label_beta)
        //サブクラスの描画（問題背景元からの線とか）
        let q1draw = Q1Draw(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        q1draw.backgroundColor = UIColor.clear
        self.view.addSubview(q1draw)
        //補助線用のキャンバスを重ねる
        ExtensionLineCanvas.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        ExtensionLineCanvas.backgroundColor = UIColor.clear
        view.addSubview(ExtensionLineCanvas)
        //平行記号用のキャンバスを重ねる
        ParallelSymbolCanvas.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        ParallelSymbolCanvas.backgroundColor = UIColor.clear
        view.addSubview(ParallelSymbolCanvas)
        
    }
    
    override func didReceiveMemoryWarning(){
            super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: ExtensionLineCanvas)
        if ExtensionLineDraw == false {
            XlineStartPoint = currentPoint
            XLine = UIBezierPath()
            XLine.lineWidth = 5
            XLine.move(to: currentPoint)
        }else{
            parallelSymbolStartPoint = currentPoint
            preParallelLine = UIBezierPath()
            preParallelLine.lineWidth = 5
            preParallelLine.move(to: currentPoint)
            print(currentPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ExtensionLineDraw == false {
            if XLine == nil {
                return
            }
            let touchEvent = touches.first!
            let currentPoint:CGPoint = touchEvent.location(in: ExtensionLineCanvas)
            XLine.addLine(to: currentPoint)
            drawLine(path: XLine, Precolor: UIColor.white)
        }else{
            if preParallelLine == nil {
                return
            }
            let touchEvent = touches.first!
            let currentPoint:CGPoint = touchEvent.location(in: ParallelSymbolCanvas)
            preParallelLine.addLine(to: currentPoint)
            drawLine(path: preParallelLine, Precolor: UIColor.white)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ExtensionLineDraw == false {
            if XLine == nil {
                return
            }
            let touchEvent = touches.first!
            let currentPoint:CGPoint = touchEvent.location(in: ExtensionLineCanvas)
            XlineEndPoint = currentPoint
            XLine.addLine(to: currentPoint)
            drawLine(path: XLine, Precolor: UIColor.white)
            lastDrawImage = ExtensionLineCanvas.image!
            //前までの線を消す
            sleep(1)
            lastDrawImage = nil
            ExtensionLineCanvas.image = nil
            //スタートとエンドを判定して範囲なら変換。まずは折点をまたがっているかを判定している。
            if (XlineStartPoint.x > 400 && XlineEndPoint.x < 400) || (XlineStartPoint.x < 400 && XlineEndPoint.x > 400) {
                if (XlineStartPoint.y > 350 && XlineStartPoint.y < 450) && (XlineEndPoint.y > 350 && XlineEndPoint.y < 450) {
                    XlineStartPoint.y = 400
                    XlineEndPoint.y = 400
                    IntersectionJudge = true
                }
            }
            //直線の描画
            if IntersectionJudge == false {
                lastDrawImage = nil
                ExtensionLineCanvas.image = nil
            }else{
                AccurateExtensionLine.lineWidth = 5
                AccurateExtensionLine.move(to: XlineStartPoint)
                AccurateExtensionLine.addLine(to: XlineEndPoint)
                drawLine(path: AccurateExtensionLine, Precolor: UIColor.white)
                lastDrawImage = ExtensionLineCanvas.image!
                IntersectionJudge = false
                //デリゲートに渡す
                delegate.q1extensionLine = AccurateExtensionLine
            }
            ExtensionLineDraw = true
        }else{
            if preParallelLine == nil {
                return
            }
            let touchEvent = touches.first!
            let currentPoint:CGPoint = touchEvent.location(in: ParallelSymbolCanvas)
            parallelSymbolEndPoint = currentPoint
            preParallelLine.addLine(to: currentPoint)
            drawParallelsymbol(path: preParallelLine)
            lastDrawImage = ParallelSymbolCanvas.image!
            //前までの線を消す
            
            sleep(1)
            lastDrawImage = nil
            ParallelSymbolCanvas.image = nil
            ExtensionLineCanvas.image = nil//前のキャンバスにも書かれてしまうからそっちも消す。けど再描画はさせてる。クラス化すべき
            AccurateParallelLine.lineWidth = 5
            
            parallelSymbolInetrSectionPoint = geometrycalculation.InterSectionCalc(L1Point: XlineStartPoint, L2Point: XlineEndPoint, A1Point: parallelSymbolStartPoint, A2Point: parallelSymbolEndPoint)
            
            //print(XlineStartPoint,XlineEndPoint,parallelSymbolInetrSectionPoint)
            
            AccurateParallelLine.move(to: CGPoint(x: parallelSymbolInetrSectionPoint.x - 30, y: parallelSymbolInetrSectionPoint.y - 30))
            AccurateParallelLine.addLine(to: parallelSymbolInetrSectionPoint)
            AccurateParallelLine.addLine(to: CGPoint(x: parallelSymbolInetrSectionPoint.x - 30, y: parallelSymbolInetrSectionPoint.y + 30))
            delegate.q1parallelSymbol = AccurateParallelLine
            drawParallelsymbol(path: AccurateParallelLine)
            
            AccurateExtensionLine.lineWidth = 5
            AccurateExtensionLine.move(to: XlineStartPoint)
            AccurateExtensionLine.addLine(to: XlineEndPoint)
            drawLine(path: AccurateExtensionLine, Precolor: UIColor.white)
            lastDrawImage = ParallelSymbolCanvas.image!
            
            delegate.q1extensionLineStartPoint = XlineStartPoint
            delegate.q1extensionLineEndPoint = XlineEndPoint
            
            sleep(1)
            
            //画面遷移させる
            
            let q1answerviewcontroller: UIViewController = Q1AnswerViewController()
            q1answerviewcontroller.modalTransitionStyle = .crossDissolve
            self.present(q1answerviewcontroller, animated: true, completion: nil)
            
 
        }

    }
    
    func drawLine(path: UIBezierPath, Precolor: UIColor) {
        UIGraphicsBeginImageContext(ExtensionLineCanvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint.zero)
        }
        let lineColor = Precolor
        lineColor.setStroke()
        path.stroke()
        self.ExtensionLineCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func drawParallelsymbol(path: UIBezierPath) {
        UIGraphicsBeginImageContext(ParallelSymbolCanvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint.zero)
        }
        let lineColor = UIColor.white
        lineColor.setStroke()
        path.stroke()
        self.ParallelSymbolCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    /*
    func Parallelsymbol(path:UIBezierPath, PLpt: CGPoint) {
        UIGraphicsBeginImageContext(ParallelSymbolCanvas.frame.size)
        if lastDrawImage != nil {
            lastDrawImage.draw(at: CGPoint.zero)
        }
        path.move(to: CGPoint(x: PLpt.x - 30, y: PLpt.y - 30))
        path.addLine(to: PLpt)
        path.addLine(to: CGPoint(x: PLpt.x - 30, y: PLpt.y + 30))
        UIColor.white.setStroke()
        path.lineWidth = 5
        path.stroke()
        self.ParallelSymbolCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    */
}

