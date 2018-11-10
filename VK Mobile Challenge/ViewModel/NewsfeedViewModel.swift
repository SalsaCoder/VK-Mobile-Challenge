//
//  NewsfeedViewModel.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

struct NewsfeedViewModel {
    let name: String
    let date: String
    let authorImageUrl: URL
    let text: String
    let photoUrls: [URL]
    let likeCounts: Int
    let commentsCount: Int
    let repostCount: Int
    let viewsCount: Int
}
