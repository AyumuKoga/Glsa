//
//  OCADraw.swift
//  glsa
//
//  Created by 古賀歩 on 2016/11/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation


class OCADraw: UIView {
    
    //既存の平行線
    let LSPoint: CGPoint = CGPoint(x: 150, y: 300)
    let MSPoint: CGPoint = CGPoint(x: 150, y: 550)
    let LEPoint: CGPoint = CGPoint(x: 900, y: 300)
    let MEPoint: CGPoint = CGPoint(x: 900, y: 550)
    
    private var FirstTapLocation: CGPoint = CGPoint.zero
    private var EndTapLocation: CGPoint = CGPoint.zero
    var LineX = UIBezierPath()
    var XFlag = false
    var FirstLineXfalg = false
    var SecondLineXflag = false
    //交点を保持するようの変数
    public var InterSectionPoint1: CGPoint = CGPoint.zero
    public var InterSectionPoint2: CGPoint = CGPoint.zero
    var drawcirclePermisson = false
    //デリゲートに書き込む交点座標とタッチ座標用のインスタンス
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func draw(_ rect: CGRect) {
        //線分Lと線分Mのインスタンスの生成
        let lineL = UIBezierPath()
        let lineM = UIBezierPath()
        
        //起点L
        lineL.move(to: LSPoint)
        //起点M
        lineM.move(to: MSPoint)
        //帰着点L
        lineL.addLine(to: LEPoint)
        //帰着点M
        lineM.addLine(to: MEPoint)

        //ラインを結ぶL
        lineL.close()
        //ラインを結ぶM
        lineM.close()
        //色の設定
        UIColor.white.setStroke()
        //ライン幅L
        lineL.lineWidth = 7
        //ライン幅M
        lineM.lineWidth = 7

        //ライン描画L
        lineL.stroke()
        //ライン描画M
        lineM.stroke()
        
        //デリゲートに既存の線を書き込んでおく
        delegate.preLineL = lineL
        delegate.preLineM = lineM
        //ライン描画X

        /*ここまでが事前描画してある平行線*/
        
        //正確にタッチされるまで、ここは何も起きない。逐次実行はされるけどね。
        LineX.move(to: FirstTapLocation)
        LineX.addLine(to: EndTapLocation)
        LineX.close()
        LineX.lineWidth = 5
        LineX.stroke()
        
        
    }
    
    //タッチの開始を感知すると呼び出される関数
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let Begintouch = touches.first!.location(in: self)
        FirstTapLocation.x = Begintouch.x
        FirstTapLocation.y = Begintouch.y
        print("FirstPoint", FirstTapLocation)
    }
    
    //タッチしたまま指を動かすと呼び出される関数
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       // print("Moved")
    }
    //タッチしていた指が離れると呼び出される関数：この中で判定もしているぞ。時間があれば判定する関数も作りたい
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touchesEnd")
        let EndTouch = touches.first!.location(in: self)
        EndTapLocation.x = EndTouch.x
        EndTapLocation.y = EndTouch.y
        print("EndPoint", EndTapLocation)
        
        //2線にかかってるかの判定をしてから再描画
        if LineInterSectionJudge(FPoint: FirstTapLocation, EPoint: EndTapLocation, Flag: XFlag) == true {
            self.setNeedsDisplay() //再描画させてるぞ
            XFlag = true
            self.delegate.touchesPointB = FirstTapLocation//デリゲートに渡してる
            self.delegate.touchesPointE = EndTapLocation//同じくデリゲートに渡してる
        }else{
            print("２線にかかってないかフラグが折れてる")
        }
        
        if FirstLineXfalg == false{
            InterSectionPoint1 = InterSectionCalc(L1Point: LSPoint, L2Point: LEPoint, A1Point: FirstTapLocation, A2Point: EndTapLocation)
            FirstLineXfalg = true
            print("交点1", InterSectionPoint1)
            self.delegate.InterSectionPoints1 = InterSectionPoint1//デリゲートに渡してる
        }
        
        if SecondLineXflag == false{
            InterSectionPoint2 = InterSectionCalc(L1Point: MSPoint, L2Point: MEPoint, A1Point: FirstTapLocation, A2Point: EndTapLocation)
            SecondLineXflag = true
            print("交点2", InterSectionPoint2)
            self.delegate.InterSectionPoints2 = InterSectionPoint2//デリゲートに渡してる
        }
        
    }
    
    //この関数で2線にかかっているか判定している。yの判定のみだからxの判定も書かないといけない。
    func LineInterSectionJudge(FPoint: CGPoint, EPoint: CGPoint,Flag: Bool) -> Bool {
        
        if FPoint.y < LSPoint.y && EPoint.y > MSPoint.y && Flag == false{
            return true
        }else if FPoint.y > MSPoint.y && EPoint.y < LSPoint.y && Flag == false{
            return true
        }else{
            return false
        }
    }
    
    //交点を計算する関数、メソッドって言い方の方が良いのか？
    func InterSectionCalc(L1Point: CGPoint, L2Point: CGPoint, A1Point: CGPoint, A2Point: CGPoint) -> CGPoint{
        var ResultPoint: CGPoint = CGPoint()
        let a1:CGFloat = (L2Point.y - L1Point.y) / (L2Point.x - L1Point.x) //a1は交点を求めるための計算用:変化の割合
        let a2:CGFloat = (A2Point.y - A1Point.y) / (A2Point.x - A1Point.x) //a2は交点を求めるための計算用:変化の割合
        ResultPoint.x = (a1*L1Point.x - L1Point.y - a2*A1Point.x + A1Point.y) / (a1 - a2)
        ResultPoint.y = (L2Point.y - L1Point.y) / (L2Point.x - L1Point.x) * (A1Point.x - L1Point.x) + L1Point.y
        return ResultPoint
    }
}
