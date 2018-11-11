//
//  PhotoAttachment.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

struct PhotoAttachment: Attachment {
    let type: String
    let photo: Photo
}

struct Photo: Decodable {
    let id: Int
    let sizes: [PhotoSize]
}

struct PhotoSize: Decodable {
    let type: PhotoSizeType
    let url: URL
    let width: Int
    let height: Int
}

enum PhotoSizeType: String, Decodable {
    case s
    case m
    case x
    case o
    case p
    case q
    case r
    case y
    case z
    case w
}
