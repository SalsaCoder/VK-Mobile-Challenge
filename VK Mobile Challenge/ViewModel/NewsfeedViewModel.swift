//
//  NewsfeedViewModel.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

struct NewsfeedViewModel {
    struct CountersViewModel {
        let likes: String?
        let comments: String?
        let reposts: String?
        let views: String?
    }

    let name: String
    let date: String
    let authorImageUrl: URL
    let text: String
    let photoUrls: [URL]
    let counters: CountersViewModel
}
