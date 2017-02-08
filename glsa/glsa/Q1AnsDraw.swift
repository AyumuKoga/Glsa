//
//  Q1AnsDraw.swift
//  glsa
//
//  Created by 古賀歩 on 2017/02/06.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit

class Q1AnsDraw: UIView {
    
    //デリゲートへの送受信用
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //計算用インスタンスの生成
    var geometrycalculation = GeometryCalculation()

    //既存の2つの平行線の始点と終点
    let LSPoint: CGPoint = CGPoint(x: 150, y: 250)
    let LEPoint: CGPoint = CGPoint(x: 900, y: 250)
    let MSPoint: CGPoint = CGPoint(x: 150, y: 550)
    let MEPoint: CGPoint = CGPoint(x: 900, y: 550)
    
    //1つの折れ線を始点、中点、終点
    let ASPoint: CGPoint = CGPoint(x: 750, y: 150)
    let AMPoint: CGPoint = CGPoint(x: 400, y: 400)//折点
    let AEPoint: CGPoint = CGPoint(x: 750, y: 650)

    var touchPointLengthOfAlpha:CGFloat = 0//アルファからの距離
    var touchPointLengthOfbeta:CGFloat = 0//ベータからの距離
    var touchPointLengthOfX:CGFloat = 0//Xからの距離
    var touchPointOfCenterPointAtTheta:CGFloat = 0//角度を求める
    
    override func draw(_ rect: CGRect) {
        var preLineL = UIBezierPath()
        var preLineM = UIBezierPath()
        var preLineUp = UIBezierPath()
        var preLineDown = UIBezierPath()
        var preExtensionLine = UIBezierPath()
        var preParalellSymbol = UIBezierPath()
        var preArcX = UIBezierPath()
        var preArcAlpha = UIBezierPath()
        var preArcBeta = UIBezierPath()
        
        preLineL = delegate.q1LineL!
        preLineM = delegate.q1LineM!
        preLineUp = delegate.q1LineUp!
        preLineDown = delegate.q1LineDown!
        preExtensionLine = delegate.q1extensionLine!
        preParalellSymbol = delegate.q1parallelSymbol!
        preArcX = delegate.q1arcX!
        preArcAlpha = delegate.q1arcAlpha!
        preArcBeta = delegate.q1arcBeta!
        
        preLineL.lineWidth = 7
        preLineM.lineWidth = 7
        preLineUp.lineWidth = 7
        preLineDown.lineWidth = 7
        
        
        UIColor.white.setStroke()
        preLineL.stroke()
        preLineM.stroke()
        preLineUp.stroke()
        preLineDown.stroke()
        preParalellSymbol.stroke()
        
        UIColor.blue.setFill()
        preArcX.fill()
        UIColor.red.setFill()
        preArcAlpha.fill()
        UIColor.green.setFill()
        preArcBeta.fill()
        
        preArcX.lineWidth = 5
        preArcAlpha.lineWidth = 5
        preArcBeta.lineWidth = 5
        preArcX.stroke()
        preArcBeta.stroke()
        preArcAlpha.stroke()
        preExtensionLine.stroke()
        
        drawParallelsymbol(PLpt: CGPoint(x: 240, y: 250))
        drawParallelsymbol(PLpt: CGPoint(x: 240, y: 550))
        
        let arcX_Upside = UIBezierPath(arcCenter: AMPoint, radius: 100, startAngle: 0, endAngle: CGFloat(M_PI * 2) - geometrycalculation.AngleOf2Vector(V1PointVector: delegate.q1extensionLineEndPoint!, V2PointVector: ASPoint, CenterPointZero: AMPoint), clockwise: false)
        arcX_Upside.addLine(to: AMPoint)
        arcX_Upside.close()
        
        let arcX_Downside = UIBezierPath(arcCenter: AMPoint, radius: 100, startAngle: geometrycalculation.AngleOf2Vector(V1PointVector: delegate.q1extensionLineEndPoint!, V2PointVector: AEPoint, CenterPointZero: AMPoint), endAngle: 0, clockwise: false)
        arcX_Downside.addLine(to: AMPoint)
        arcX_Downside.close()
        
        delegate.q1XSectorUpside = arcX_Upside
        delegate.q1XSectorDownside = arcX_Downside
        
    }
    
    func drawParallelsymbol(PLpt: CGPoint) {
        let parallelsymbol = UIBezierPath()
        parallelsymbol.move(to: CGPoint(x: PLpt.x - 30, y: PLpt.y - 30))
        parallelsymbol.addLine(to: PLpt)
        parallelsymbol.addLine(to: CGPoint(x: PLpt.x - 30, y: PLpt.y + 30))
        UIColor.white.setStroke()
        parallelsymbol.lineWidth = 5
        parallelsymbol.stroke()
    }
    
    
    func getTouchSector(TouchPoint:CGPoint) -> String {
        
        let preInterSectionPointAlpha: CGPoint = delegate.q1InterSectionPointAlpha!
        let preInterSectionPointBeta: CGPoint = delegate.q1InterSectionPointBeta!
        let preExtensionLineEpt: CGPoint = delegate.q1extensionLineEndPoint!
        
        var touch_theta = CGFloat()
        
        touchPointLengthOfAlpha = geometrycalculation.getVLength(VPoint: TouchPoint, CenterPoint: geometrycalculation.InterSectionCalc(L1Point: LSPoint, L2Point: LEPoint, A1Point: ASPoint, A2Point: AMPoint))
        touchPointLengthOfbeta = geometrycalculation.getVLength(VPoint: TouchPoint, CenterPoint: geometrycalculation.InterSectionCalc(L1Point: MSPoint, L2Point: MEPoint, A1Point: AMPoint, A2Point: AEPoint))
        touchPointLengthOfX = geometrycalculation.getVLength(VPoint: TouchPoint, CenterPoint: AMPoint)
        
        /* デバック用
        print(touchPointLengthOfAlpha)
        print(touchPointLengthOfbeta)
        print(touchPointLengthOfX)
        */
        if touchPointLengthOfAlpha <= 80 && preInterSectionPointAlpha.y <= TouchPoint.y {
            touch_theta = geometrycalculation.AngleOf2Vector(V1PointVector: TouchPoint, V2PointVector: LSPoint, CenterPointZero: preInterSectionPointAlpha)
            let theta_alpha = geometrycalculation.AngleOf2Vector(V1PointVector: AMPoint, V2PointVector: LSPoint, CenterPointZero: preInterSectionPointAlpha)
            if 0 <= touch_theta && theta_alpha >= touch_theta {
                //print("Alpha")
                return "Alpha"
            }
        }
        
        if touchPointLengthOfX <= 100 && TouchPoint.y <= AMPoint.y {
            touch_theta = geometrycalculation.AngleOf2Vector(V1PointVector: TouchPoint, V2PointVector: preExtensionLineEpt, CenterPointZero: AMPoint)
            let theta_xUpside = geometrycalculation.AngleOf2Vector(V1PointVector: ASPoint, V2PointVector: preExtensionLineEpt, CenterPointZero: AMPoint)
            if 0 <= touch_theta && touch_theta <= theta_xUpside {
                //print("XUpside")
                return "XUpside"
            }
        }
        
        if touchPointLengthOfX <= 100 && TouchPoint.y >= AMPoint.y {
            touch_theta = geometrycalculation.AngleOf2Vector(V1PointVector: TouchPoint, V2PointVector: preExtensionLineEpt, CenterPointZero: AMPoint)
            let theta_xDownside = geometrycalculation.AngleOf2Vector(V1PointVector: AEPoint, V2PointVector: preExtensionLineEpt, CenterPointZero: AMPoint)
            if 0 <= touch_theta && touch_theta <= theta_xDownside {
                //print("XDownside")
                return "XDownside"
            }
        }
        
        if touchPointLengthOfbeta <= 80 && preInterSectionPointBeta.y <= TouchPoint.y {
            touch_theta = geometrycalculation.AngleOf2Vector(V1PointVector: TouchPoint, V2PointVector: MEPoint, CenterPointZero: preInterSectionPointBeta)
            let touch_beta = geometrycalculation.AngleOf2Vector(V1PointVector: AEPoint, V2PointVector: MEPoint, CenterPointZero: preInterSectionPointBeta)
            if 0 <= touch_theta && touch_beta >= touch_theta {
                //print("beta")
                return "Beta"
            }
        }
        return "NoSector"
    }

}
