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
    let type: String
    let url: URL
    let width: Int
    let height: Int
}
