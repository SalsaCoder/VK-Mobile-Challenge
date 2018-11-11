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

    struct PhotoViewModel {
        let url: URL
        let width: Int
        let height: Int
    }

    let name: String
    let date: String
    let authorImageUrl: URL
    let text: String
    var shouldTrimmText: Bool
    let photos: [PhotoViewModel]
    let counters: CountersViewModel
}
