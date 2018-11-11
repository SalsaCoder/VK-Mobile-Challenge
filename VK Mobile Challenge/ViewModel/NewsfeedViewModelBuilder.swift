//
//  NewsfeedViewModelBuilder.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedViewModelBuilder {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")

        return dateFormatter
    }()

    func buildViewModels(from newsfeed: Newsfeed) -> [NewsfeedViewModel] {
        var viewModels = [NewsfeedViewModel]()

        let originalItems = newsfeed.items.filter({ $0.isRepost == false })

        for item in originalItems {
            guard let user = newsfeed.profiles.first(where: { $0.id == item.sourceId }) else {
                continue
            }

            let name = "\(user.firstName) \(user.lastName)"
            let date = dateFormatter.string(from: Date(timeIntervalSince1970: item.date))

            let photoUrls =  item.attachments?.compactMap({ (item) -> URL? in
                guard let photoAttachment = item as? PhotoAttachment else {
                    return nil
                }

                return photoAttachment.photo.sizes.first(where: { $0.type == .r })?.url
            })

            let counters = makeCountersViewModel(item: item)

            let viewModel = NewsfeedViewModel(name: name,
                                              date: date,
                                              authorImageUrl: user.photo,
                                              text: item.text,
                                              photoUrls: photoUrls ?? [],
                                              counters: counters)

            viewModels.append(viewModel)
        }

        return viewModels
    }

    private func makeCountersViewModel(item: NewsfeedItem) -> NewsfeedViewModel.CountersViewModel {

        let likes = item.likes.count
        let comments = item.comments.count
        let reposts = item.reposts.count
        let views = item.views?.count ?? 0

        return NewsfeedViewModel.CountersViewModel(likes: likes > 0 ? "\(likes)" : nil,
                                                   comments: comments > 0 ? "\(comments)" : nil,
                                                   reposts: reposts > 0 ? "\(reposts)" : nil,
                                                   views: views > 0 ? "\(views)" : nil)
    }
}
