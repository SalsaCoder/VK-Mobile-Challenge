//
//  Newsfeed.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

struct Newsfeed: Decodable {
    let items: [NewsfeedItem]
    let profiles: [User]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case nextFrom = "next_from"
    }
}

struct NewsfeedItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case date
        case text
        case type
        case comments
        case likes
        case reposts
        case views
        case  attachments
        case sourceId = "source_id"
    }

    let date: TimeInterval
    let sourceId: Int
    let text: String
    let type: String
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let views: Views?
    let attachments: [Attachment]?

    init(date: TimeInterval,
         sourceId: Int,
         text: String,
         type: String,
         comments: Comments,
         likes: Likes,
         reposts: Reposts,
         views: Views?,
         attachments: [Attachment]?) {
        self.date = date
        self.sourceId = sourceId
        self.text = text
        self.type = type
        self.comments = comments
        self.likes = likes
        self.reposts = reposts
        self.views = views
        self.attachments = attachments
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let date = try container.decode(TimeInterval.self, forKey: .date)
        let sourceId = try container.decode(Int.self, forKey: .sourceId)
        let text = try container.decode(String.self, forKey: .text)
        let type = try container.decode(String.self, forKey: .type)

        let comments = try container.decode(Comments.self, forKey: .comments)
        let likes = try container.decode(Likes.self, forKey: .likes)
        let reposts = try container.decode(Reposts.self, forKey: .reposts)
        let views = try container.decodeIfPresent(Views.self, forKey: .views)

        let attachments = try container.decodeIfPresent([FailableDecodable<PhotoAttachment>].self, forKey: .attachments)?.compactMap({ $0.base })

        self.init(date: date,
                  sourceId: sourceId,
                  text: text,
                  type: type,
                  comments: comments,
                  likes: likes,
                  reposts: reposts,
                  views: views,
                  attachments: attachments)
    }
}

// Хак, чтобы не разбирать type из контейнера
private struct FailableDecodable<Base : Decodable> : Decodable {
    let base: Base?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
