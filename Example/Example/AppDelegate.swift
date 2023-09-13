//
//  AppDelegate.swift
//  Example
//
//  Created by William.Weng on 2023/9/11.
//

import UIKit
import WWSignInWith3rd_Apple

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return WWSignInWith3rd.Facebook.shared.canLaunching(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        
        return WWSignInWith3rd.Facebook.shared.canOpenURL(app, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}



