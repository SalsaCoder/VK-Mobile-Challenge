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
    static let apiVersion = "5.87"

    enum URLs {
        private static let baseUrl = "https://api.vk.com/method"

        static let users = baseUrl + "/users.get"
        static let newsfeed = baseUrl + "/newsfeed.get"
    }

    enum Colors {
        static let grayGradientLayer: CAGradientLayer = {
            let color = [UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1.0).cgColor,
                         UIColor(red: 0.92, green: 0.93, blue: 0.94, alpha: 1.0).cgColor]

            let locations = [0.0, 1.0] as [NSNumber]

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = color
            gradientLayer.locations = locations

            return gradientLayer
        }()
    }

    enum UI {
        static let maximumNumberOfLines = 6
    }
}
