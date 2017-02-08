//
//  Q1Draw.swift
//  glsa
//
//  Created by 古賀歩 on 2017/01/12.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit

class Q1Draw: UIView {
    
    //既存の2つの平行線の始点と終点
    let LSPoint: CGPoint = CGPoint(x: 150, y: 250)
    let LEPoint: CGPoint = CGPoint(x: 900, y: 250)
    let MSPoint: CGPoint = CGPoint(x: 150, y: 550)
    let MEPoint: CGPoint = CGPoint(x: 900, y: 550)
    
    //1つの折れ線を始点、中点、終点
    let ASPoint: CGPoint = CGPoint(x: 750, y: 150)
    let AMPoint: CGPoint = CGPoint(x: 400, y: 400)//折点
    let AEPoint: CGPoint = CGPoint(x: 750, y: 650)
    let geometrycalculation = GeometryCalculation()//計算用インスタンス生成
    var delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func draw(_ rect: CGRect) {

        
        let LineL = UIBezierPath()
        let LineM = UIBezierPath()
        let LineA_Up = UIBezierPath()
        let LineA_Down = UIBezierPath()
        
        //LineL
        LineL.move(to: LSPoint)
        LineL.addLine(to: LEPoint)
        LineL.close()
        LineL.lineWidth = 7
        //LineM
        LineM.move(to: MSPoint)
        LineM.addLine(to: MEPoint)
        LineM.close()
        LineM.lineWidth = 7
        //LineA_Upside
        LineA_Up.move(to: ASPoint)
        LineA_Up.addLine(to: AMPoint)
        LineA_Up.close()
        LineA_Up.lineWidth = 7
        //LineA_Downside
        LineA_Down.move(to: AMPoint)
        LineA_Down.addLine(to: AEPoint)
        LineA_Down.close()
        LineA_Down.lineWidth = 7
        
        
        //描画
        UIColor.white.setStroke()
        LineL.stroke()
        LineM.stroke()
        LineA_Up.stroke()
        LineA_Down.stroke()
        
        //角Xを計算して描画
        let Theta_X = geometrycalculation.AngleOf2Vector(V1PointVector: ASPoint, V2PointVector: AEPoint, CenterPointZero: AMPoint)
        
        let arcX = UIBezierPath(arcCenter: AMPoint, radius: 100, startAngle: 0 - Theta_X/2, endAngle: Theta_X/2, clockwise: true)
        arcX.addLine(to: AMPoint)
        UIColor(red: 0, green: 0, blue: 1, alpha: 0.5).setFill()
        UIColor.white.setStroke()
        arcX.close()
        arcX.lineWidth = 5
        arcX.fill()
        arcX.stroke()
        
        //角αを計算して描画
        let InterPoint_alpha:CGPoint = geometrycalculation.InterSectionCalc(L1Point: LSPoint, L2Point: LEPoint, A1Point: ASPoint, A2Point: AMPoint)
        let Theta_alpha:CGFloat = geometrycalculation.AngleOf2Vector(V1PointVector: LSPoint, V2PointVector: AMPoint, CenterPointZero: InterPoint_alpha)
        let arc_alpha = UIBezierPath(arcCenter: InterPoint_alpha, radius: 80, startAngle: CGFloat(M_PI) - Theta_alpha, endAngle: CGFloat(M_PI), clockwise: true)
        arc_alpha.addLine(to: InterPoint_alpha)
        UIColor.red.setFill()
        UIColor.white.setStroke()
        arc_alpha.close()
        arc_alpha.lineWidth = 5
        arc_alpha.fill()
        arc_alpha.stroke()
        
        //角βを計算して描画
        let InterPoint_beta:CGPoint = geometrycalculation.InterSectionCalc(L1Point: MSPoint, L2Point: MEPoint, A1Point: AMPoint, A2Point: AEPoint)
        let Theta_beta:CGFloat = geometrycalculation.AngleOf2Vector(V1PointVector: MEPoint, V2PointVector: AEPoint, CenterPointZero: InterPoint_beta)
        let arc_beta = UIBezierPath(arcCenter: InterPoint_beta, radius: 80, startAngle: Theta_beta, endAngle: 0, clockwise: false)
        arc_beta.addLine(to: InterPoint_beta)
        UIColor.green.setFill()
        UIColor.white.setStroke()
        arc_beta.close()
        arc_beta.lineWidth = 5
        arc_beta.fill()
        arc_beta.stroke()
        
        //デリゲートに渡す部分
        delegate.q1LineL = LineL
        delegate.q1LineM = LineM
        delegate.q1LineUp = LineA_Up
        delegate.q1LineDown = LineA_Down
        delegate.q1InterSectionPointAlpha = InterPoint_alpha
        delegate.q1InterSectionPointBeta = InterPoint_beta
        delegate.q1arcX = arcX
        delegate.q1arcAlpha = arc_alpha
        delegate.q1arcBeta = arc_beta
        
        drawParallelsymbol(PLpt: CGPoint(x: LSPoint.x + 90, y: LSPoint.y))
        drawParallelsymbol(PLpt: CGPoint(x: MSPoint.x + 90, y: MSPoint.y))
    }
    //平行記号を描画するメソッド。引数PLptはparallel_Line_symbol(平行線の記号)を
    func drawParallelsymbol(PLpt: CGPoint) {
        let parallelsymbol = UIBezierPath()
        parallelsymbol.move(to: CGPoint(x: PLpt.x - 30, y: PLpt.y - 30))
        parallelsymbol.addLine(to: PLpt)
        parallelsymbol.addLine(to: CGPoint(x: PLpt.x - 30, y: PLpt.y + 30))
        UIColor.white.setStroke()
        parallelsymbol.lineWidth = 5
        parallelsymbol.stroke()
    }
}
