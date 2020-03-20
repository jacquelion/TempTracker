//
//  AppDelegate.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/19/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    let center = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let sharedCache: URLCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        URLCache.shared = sharedCache
        return true
    }
}

