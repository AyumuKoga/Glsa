//
//  AppDelegate.swift
//  glsa
//
//  Created by 古賀歩 on 2016/11/16.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    /* 対頂角・同位角・錯角ようのデリゲート */
    var touchesPointB: CGPoint? = CGPoint.zero
    var touchesPointE: CGPoint? = CGPoint.zero
    var InterSectionPoints1: CGPoint? = CGPoint.zero
    var InterSectionPoints2: CGPoint? = CGPoint.zero
    var preLineL: UIBezierPath? = UIBezierPath()
    var preLineM: UIBezierPath? = UIBezierPath()
    
    /* 問１用のデリゲート */
    var q1LineL: UIBezierPath? = UIBezierPath()
    var q1LineM: UIBezierPath? = UIBezierPath()
    var q1LineUp: UIBezierPath? = UIBezierPath()
    var q1LineDown: UIBezierPath? = UIBezierPath()
    var q1InterSectionPointAlpha:CGPoint? = CGPoint()
    var q1InterSectionPointBeta:CGPoint? = CGPoint()
    var q1arcX: UIBezierPath? = UIBezierPath()
    var q1arcAlpha: UIBezierPath? = UIBezierPath()
    var q1arcBeta: UIBezierPath? = UIBezierPath()
    var q1extensionLine: UIBezierPath? = UIBezierPath()
    var q1extensionLineStartPoint: CGPoint? = CGPoint()
    var q1extensionLineEndPoint: CGPoint? = CGPoint()
    var q1parallelSymbol: UIBezierPath? = UIBezierPath()
    var q1XSectorUpside: UIBezierPath? = UIBezierPath()
    var q1XSectorDownside: UIBezierPath? = UIBezierPath()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //最初に表示する画面
        //StartViewControllerの生成
        let myFirstViewController: StartViewController = StartViewController()//初期画面
        //UIWindowの生成
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //rootViewControllerにNatigattionControllerを設定する
        self.window?.rootViewController = myFirstViewController
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

