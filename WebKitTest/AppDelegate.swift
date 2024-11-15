//
//  AppDelegate.swift
//  WebKitTest
//
//  Created by Mikhail Kalatsei on 16/05/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = WebKitViewController()
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

