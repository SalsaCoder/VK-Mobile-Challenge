//
//  User.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

struct APIResponse<T: Decodable>: Decodable {
    let response: T
}

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: URL

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
}
