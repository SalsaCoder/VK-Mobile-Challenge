//
//  Newsfeed.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

struct Newsfeed: Decodable {
    let items: [NewsfeedItem]

    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items
        case nextFrom = "next_from"
    }
}

struct NewsfeedItem: Decodable {
    let date: TimeInterval
    let text: String
    let type: String

    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let views: Views
}

struct Comments: Decodable {
    let count: Int
}

struct Likes: Decodable {
    let count: Int
}

struct Reposts: Decodable {
    let count: Int
}

struct Views: Decodable {
    let count: Int
}
