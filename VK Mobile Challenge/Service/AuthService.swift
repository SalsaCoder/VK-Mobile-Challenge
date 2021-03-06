//
//  AuthService.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authService(_ authService: AuthService, didAuthorizeWith token: Token)
    func authServiceDidFail(_ authService: AuthService)
}

private let scope = ["wall", "friends"]

final class AuthService: NSObject {
    var token: Token?
    weak var delegate: AuthServiceDelegate?

    override init() {
        super.init()

        VKSdk.initialize(withAppId: Constants.appId)?.register(self)
    }

    func requestAuthorization() {
        VKSdk.wakeUpSession(scope) { [weak self] (state, error) in
            guard let strongSelf = self else {
                return
            }

            switch state {
            case .authorized:
                if let vkToken = VKSdk.accessToken() {
                    strongSelf.token = Token(userId: vkToken.userId, accessToken: vkToken.accessToken)
                    strongSelf.delegate?.authService(strongSelf, didAuthorizeWith: strongSelf.token!)
                }

                break
            case .initialized:
                VKSdk.authorize(scope)
                break
            default:
                strongSelf.delegate?.authServiceDidFail(strongSelf)
                break
            }
        }
    }
}

extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let vkToken = VKSdk.accessToken() {
            self.token = Token(userId: vkToken.userId, accessToken: vkToken.accessToken)
            delegate?.authService(self, didAuthorizeWith: self.token!)
        }
    }

    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceDidFail(self)
    }
}
