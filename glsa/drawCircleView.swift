//
//  drawCircleView.swift
//  glsa
//
//  Created by 古賀歩 on 2016/12/06.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class drawCircleView: UIView {
    //デリゲートから必要な変数を呼び出す用の宣言
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    var circlePointUp = CGPoint.zero
    var circlePointDown = CGPoint.zero
    var angle_red:CGFloat = 0
    var touchesPointLength:CGFloat = 0 //タッチされた点の原点からの距離
    var touchesPoint_theta:CGFloat = 0 //タッチされた座標の原点からの角度θ
    var SetOrNot:Bool = false
    var TouchSectorDecision:Bool = false
    
    var arcA:UIBezierPath? = nil
    var arcB:UIBezierPath? = nil
    var arcC:UIBezierPath? = nil
    var arcD:UIBezierPath? = nil
    var arcE:UIBezierPath? = nil
    var arcF:UIBezierPath? = nil
    var arcG:UIBezierPath? = nil
    var arcH:UIBezierPath? = nil
    
    var AColor:UIColor = UIColor.red
    var BColor:UIColor = UIColor.blue
    var CColor:UIColor = UIColor.yellow
    var DColor:UIColor = UIColor.orange
    var EColor:UIColor = UIColor.magenta
    var FColor:UIColor = UIColor.cyan
    var GColor:UIColor = UIColor.brown
    var HColor:UIColor = UIColor.purple
    var LineColor:UIColor = UIColor.white
    
    var TouchSectorFirst:String? = nil
    var TouchSectorSecond:String? = nil
    
    //ここからがメイン
    override func draw(_ rect: CGRect) {
        //前画面で描画した線を描画
        var PreLineL = UIBezierPath()
        var PreLineM = UIBezierPath()
        let PreLineX = UIBezierPath()

        
        PreLineL = delegate.preLineL!
        PreLineM = delegate.preLineM!
        PreLineX.move(to: delegate.touchesPointB!)
        PreLineX.addLine(to: delegate.touchesPointE!)
        PreLineX.lineWidth = 7
        PreLineX.close()
        
        drawSector()//扇形の描画
        
        UIColor.white.setStroke()
        PreLineL.stroke()
        PreLineM.stroke()
        PreLineX.stroke()
        

    }
    //ここまでメイン
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPosition = touches.first!.location(in: self)
        //タッチされた扇形をハイライトする構造を追加したい
        //TouchSectorSecond = getTouchSector(TouchPoint: touchPosition)
        if SetOrNot == false {
            TouchSectorFirst = getTouchSector(TouchPoint: touchPosition)
            if TouchSectorFirst == "NoSector" {
                SetOrNot = false
                print("false")
            }else{
                print(TouchSectorFirst! + "がセットされた")
                SetOrNot = true
                print("true")
            }
        }else{
            //次にタッチした扇形を取得して数学的に等しければ色を塗る。そしてリセット
            TouchSectorSecond = getTouchSector(TouchPoint: touchPosition)
            print(TouchSectorSecond!)
            if TouchSectorSecond == "NoSector"{
                SetOrNot = false
            }else{
                print(TouchSectorSecond! + "がセットされた")
                SectorDecision(SectorFirst: TouchSectorFirst!, SectorSecond: TouchSectorSecond!)
            }
            SetOrNot = false
            print("false")
            setNeedsDisplay()
        }
    }
    
    //rとθに変換してから判定を行う.(x,y)->(r,θ)へ変換し、その範囲で判定する
    func getTouchSector(TouchPoint:CGPoint) -> String {
        //print("基準",(delegate.InterSectionPoints1!.y + delegate.InterSectionPoints2!.y) / 2)
        if TouchPoint.y < (delegate.InterSectionPoints1!.y + delegate.InterSectionPoints2!.y) / 2{
            let touchR = getVLength(VPoint: TouchPoint, CenterPoint: delegate.InterSectionPoints1!)
            let touch_theta = AngleOf2Vector(V1PointVector: TouchPoint, V2PointVector: CGPoint(x: 900,y: 300), CenterPointZero: delegate.InterSectionPoints1!)
            touchesPointLength = touchR
            touchesPoint_theta = touch_theta
            //print("θ:",touch_theta)
            //print("上の円")
            if touch_theta > 0 && touch_theta < angle_red && TouchPoint.y < 300 && touchesPointLength <= 100{
                print("A")
                return "A"
            }
            
            if touch_theta > angle_red && touch_theta < CGFloat(M_PI) && TouchPoint.y < 300 && touchesPointLength <= 100{
                print("B")
                return "B"
            }
            
            if touch_theta < CGFloat(M_PI) && touch_theta > CGFloat(M_PI) - angle_red && TouchPoint.y > 300 && touchesPointLength <= 100{
                print("C")
                return "C"
            }
            
            if touch_theta < CGFloat(M_PI) - angle_red && touch_theta > 0 && TouchPoint.y > 300 && touchesPointLength <= 100 {
                print("D")
                return "D"
            }
            
            //たぶん関数化してからスイッチ文に変更した方が理想的だから書き直すべき
            
        }else if(TouchPoint.y > (delegate.InterSectionPoints1!.y + delegate.InterSectionPoints2!.y) / 2){
            
            let touchR = getVLength(VPoint: TouchPoint, CenterPoint: delegate.InterSectionPoints2!)
            let touch_theta = AngleOf2Vector(V1PointVector: TouchPoint, V2PointVector: CGPoint(x: 900,y: 550), CenterPointZero: delegate.InterSectionPoints2!)
            touchesPointLength = touchR
            touchesPoint_theta = touch_theta
            //print(touch_theta)
            //print("下の円")
            
            if touch_theta > 0 && touch_theta < angle_red && TouchPoint.y < 550 && touchesPointLength <= 100{
                print("E")
                return "E"
            }
            
            if touch_theta > angle_red && touch_theta < CGFloat(M_PI) && TouchPoint.y < 550 && touchesPointLength <= 100{
                print("F")
                return "F"
            }
            
            if touch_theta < CGFloat(M_PI) && touch_theta > CGFloat(M_PI) - angle_red && TouchPoint.y > 550 && touchesPointLength <= 100{
                print("G")
                return "G"
            }
            
            if touch_theta < CGFloat(M_PI) - angle_red && touch_theta > 0 && TouchPoint.y > 550 && touchesPointLength <= 100 {
                print("H")
                return "H"
            }

        }else{
            return "NoSector"
        }
        return "NoSector"
    }
    
    //扇形描画関数。これをgetTouchSectorと組み合わせて、タッチされたところの扇形だけ描画させるようにする
    func drawSector(){
        //中心点とタッチ座標をdelegateからの代入
        circlePointUp = delegate.InterSectionPoints1!
        circlePointDown = delegate.InterSectionPoints2!
        //print("up",circlePointUp)
        //print("down",circlePointDown)
        
        
        
        //8つの扇形の描画。ここは関数で書かないとダサい
        let Angle_A:CGFloat = AngleOf2Vector(V1PointVector: delegate.touchesPointB!, V2PointVector: CGPoint(x:900, y:300), CenterPointZero: circlePointUp)
        
        angle_red = Angle_A
        
        arcA = UIBezierPath(arcCenter: circlePointUp, radius: 100, startAngle: 0, endAngle: CGFloat(2*M_PI) - Angle_A, clockwise: false)
        arcA?.addLine(to: circlePointUp)
        AColor.setFill()
        AColor.setStroke()
        arcA?.close()
        arcA?.lineWidth = 3
        arcA?.fill()
        arcA?.stroke()
        
        
        let Angle_B:CGFloat = CGFloat(2*M_PI) - Angle_A
        arcB = UIBezierPath(arcCenter: circlePointUp, radius: 100, startAngle: Angle_B, endAngle: CGFloat(M_PI), clockwise: false)
        arcB?.addLine(to: circlePointUp)
        BColor.setFill()
        BColor.setStroke()
        arcB?.close()
        arcB?.lineWidth = 3
        arcB?.fill()
        arcB?.stroke()
        
        let Angle_C:CGFloat = CGFloat(M_PI) - Angle_A
        arcC = UIBezierPath(arcCenter: circlePointUp, radius: 100, startAngle: CGFloat(M_PI), endAngle: Angle_C, clockwise: false)
        arcC?.addLine(to: circlePointUp)
        CColor.setFill()
        CColor.setStroke()
        arcC?.close()
        arcC?.lineWidth = 3
        arcC?.fill()
        arcC?.stroke()
        
        let Angle_D:CGFloat = CGFloat(2*M_PI)
        arcD = UIBezierPath(arcCenter: circlePointUp, radius: 100, startAngle: Angle_C, endAngle: Angle_D, clockwise: false)
        arcD?.addLine(to: circlePointUp)
        DColor.setFill()
        DColor.setStroke()
        arcD?.close()
        arcD?.lineWidth = 3
        arcD?.fill()
        arcD?.stroke()
        
        //下の交点の方も描画
        arcE = UIBezierPath(arcCenter: circlePointDown, radius: 100, startAngle: 0, endAngle: CGFloat(2*M_PI) - Angle_A, clockwise: false)
        arcE?.addLine(to: circlePointDown)
        EColor.setFill()
        EColor.setStroke()
        arcE?.close()
        arcE?.lineWidth = 3
        arcE?.fill()
        arcE?.stroke()
        
        arcF = UIBezierPath(arcCenter: circlePointDown, radius: 100, startAngle: Angle_B, endAngle: CGFloat(M_PI), clockwise: false)
        arcF?.addLine(to: circlePointDown)
        FColor.setFill()
        FColor.setStroke()
        arcF?.close()
        arcF?.lineWidth = 3
        arcF?.fill()
        arcF?.stroke()
        
        arcG = UIBezierPath(arcCenter: circlePointDown, radius: 100, startAngle: CGFloat(M_PI), endAngle: Angle_C, clockwise: false)
        arcG?.addLine(to: circlePointDown)
        GColor.setFill()
        GColor.setStroke()
        arcG?.close()
        arcG?.lineWidth = 3
        arcG?.fill()
        arcG?.stroke()
        
        arcH = UIBezierPath(arcCenter: circlePointDown, radius: 100, startAngle: Angle_C, endAngle: Angle_D, clockwise: false)
        arcH?.addLine(to: circlePointDown)
        HColor.setFill()
        HColor.setStroke()
        arcH?.close()
        arcH?.lineWidth = 3
        arcH?.fill()
        arcH?.stroke()
        
        //ここまで関数でまとめないとダサいぞ
        

    }
    
    //vectorLengthを計算するメソッドを定義。
    func getVLength(VPoint: CGPoint,CenterPoint: CGPoint) -> CGFloat{
        var length:CGFloat = 0
        length = pow(pow(VPoint.x - CenterPoint.x, 2) + pow(VPoint.y - CenterPoint.y, 2) , 0.5)
        return length
    }
    
    //内積を計算するメソッド
    func get_inner_Product(VPoint1: CGPoint,VPoint2: CGPoint,CenterPoint: CGPoint) -> CGFloat{
        var innerProduct:CGFloat = 0
        innerProduct = (VPoint1.x - CenterPoint.x)*(VPoint2.x - CenterPoint.x) + (VPoint1.y - CenterPoint.y)*(VPoint2.y - CenterPoint.y)
        return innerProduct
    }
    
    //２つのベクトルの角度を返すメソッド
    func AngleOf2Vector(V1PointVector:CGPoint,V2PointVector:CGPoint,CenterPointZero:CGPoint) -> CGFloat{
        var cos_theta:CGFloat = 0
        var theta:CGFloat = 0
        let length_a = getVLength(VPoint: V1PointVector, CenterPoint: CenterPointZero)
        let length_b = getVLength(VPoint: V2PointVector, CenterPoint: CenterPointZero)
        let Product = get_inner_Product(VPoint1: V1PointVector, VPoint2: V2PointVector,CenterPoint: CenterPointZero)
        
        //cosθを求める
        cos_theta = Product / (length_a * length_b)
        //逆関数arcCosθを使ってθを抽出
        theta = acos(cos_theta)
        
        return theta
    }
    
    //二つの扇形を入力とし、数学的に正しければ色を変更するメソッド
    func SectorDecision(SectorFirst:String,SectorSecond:String){
        let SectorF:String = SectorFirst
        let SectorS:String = SectorSecond
        if SectorF == "A" {
            if SectorS == "C"{
                CColor = AColor
            }
            if SectorS == "E" {
                EColor = AColor
            }
        }
        if SectorF == "B" {
            if SectorS == "D" {
                DColor = BColor
            }
            if SectorS == "F" {
                FColor = BColor
            }
        }
        if SectorF == "C" {
            if SectorS == "A" {
                AColor = CColor
            }
            if SectorS == "E" {
                EColor = CColor
            }
            if SectorS == "G" {
                GColor = CColor
            }
        }
        if SectorF == "D" {
            if SectorS == "B" {
                BColor = DColor
            }
            if SectorS == "F" {
                FColor = DColor
            }
            if SectorS == "H" {
                HColor = DColor
            }
        }
        if SectorF == "E" {
            if SectorS == "C" {
                CColor = EColor
            }
            if SectorS == "G" {
                GColor = EColor
            }
            if SectorS == "A" {
                AColor = EColor
            }
        }
        if SectorF == "F" {
            if SectorS == "B" {
                BColor = FColor
            }
            if SectorS == "D" {
                DColor = FColor
            }
            if SectorS == "H" {
                HColor = FColor
            }
        }
        if SectorF == "G" {
            if SectorS == "E" {
                EColor = GColor
            }
            if SectorS == "C" {
                CColor = GColor
            }
        }
        if SectorF == "H" {
            if SectorS == "F" {
                FColor = HColor
            }
            if SectorS == "D" {
                DColor = HColor
            }
        }
    }//いやーこの関数ださいなぁ。もっと上手に書けるはず。
    
}
