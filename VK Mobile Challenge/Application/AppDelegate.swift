//
//  AppDelegate.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        VKSdk.initialize(withAppId: "")?.register(self)

        let scope = ["friends", "email"]

        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {

            }

            switch state {
            case .authorized:
                break
            case .initialized:
                VKSdk.authorize(scope)
                break
            default:
                break
            }
        }

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let application = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String {
            VKSdk.processOpen(url, fromApplication: application)
        }

        return true
    }

}

extension AppDelegate: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
    }

    func vkSdkUserAuthorizationFailed() {
    }
}
