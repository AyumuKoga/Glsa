//
//  GeometryCalcukation.swift
//  glsa
//
//  Created by 古賀歩 on 2017/01/13.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class GeometryCalculation {
    
    var currentPoint: CGPoint = CGPoint.zero
    
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
    //交点を計算するメソッド
    func InterSectionCalc(L1Point: CGPoint, L2Point: CGPoint, A1Point: CGPoint, A2Point: CGPoint) -> CGPoint{
        var ResultPoint: CGPoint = CGPoint()
        let a1:CGFloat = (L2Point.y - L1Point.y) / (L2Point.x - L1Point.x) //a1は交点を求めるための計算用:変化の割合
        let a2:CGFloat = (A2Point.y - A1Point.y) / (A2Point.x - A1Point.x) //a2は交点を求めるための計算用:変化の割合
        ResultPoint.x = (a1*L1Point.x - L1Point.y - a2*A1Point.x + A1Point.y) / (a1 - a2)
        ResultPoint.y = (L2Point.y - L1Point.y) / (L2Point.x - L1Point.x) * (A1Point.x - L1Point.x) + L1Point.y
        return ResultPoint
    }
    //平行記号を描画するメソッド
    func drawParallelsymbol(PLpt: CGPoint) {
        let parallelsymbol = UIBezierPath()
        parallelsymbol.move(to: CGPoint(x: PLpt.x - 30, y: PLpt.y - 30))
        parallelsymbol.addLine(to: PLpt)
        parallelsymbol.addLine(to: CGPoint(x: PLpt.x - 30, y: PLpt.y + 30))
        UIColor.white.setStroke()
        parallelsymbol.lineWidth = 5
        parallelsymbol.stroke()
    }
    //

}
