//
//  AppDelegate.swift
//  Mc3plus_SpeechText
//
//  Created by Benny Kurniawan on 21/11/18.
//  Copyright © 2018 Benny Kurniawan. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var bgmSound : AVAudioPlayer?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let view = MainSceneViewController()
        let nav = UINavigationController(rootViewController: view)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        soundsInit()
        bgmSound?.volume = 0.7
        bgmSound?.play()
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
    
    func soundsInit() {
        let soundURL = URL.init(fileURLWithPath: Bundle.main.path(forResource: "rain_and_thunder", ofType: "wav")!)
        
        do {
            try bgmSound = AVAudioPlayer(contentsOf: soundURL)
            bgmSound?.prepareToPlay()
            bgmSound?.numberOfLoops = -1
        }
        catch {
            print("error: \(error.localizedDescription)")
        }
    }


}

