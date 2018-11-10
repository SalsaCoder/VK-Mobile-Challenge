//
//  Constants.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

enum Constants {
    static let appId = "6746477"
    static let apiVersion = "5.5"

    enum URLs {
        private static let baseUrl = "https://api.vk.com/method"

        static let users = baseUrl + "/users.get"
        static let newsfeed = baseUrl + "/newsfeed.get"
    }
}
