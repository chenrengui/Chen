//
//  AppDelegate.swift
//  Chen
//
//  Created by iOS on 2023/10/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}

