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
        VKSdk.initialize(withAppId: Constants.appId)?.register(self)

        VKSdk.wakeUpSession(nil) { (state, error) in

            switch state {
            case .authorized:
                break
            case .initialized:
                VKSdk.authorize(nil)
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
