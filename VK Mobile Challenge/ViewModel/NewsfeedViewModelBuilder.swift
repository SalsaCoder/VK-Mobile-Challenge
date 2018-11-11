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

                return photoAttachment.photo.sizes.last?.url
            })

            let viewModel = NewsfeedViewModel(name: name,
                                              date: date,
                                              authorImageUrl: user.photo,
                                              text: item.text,
                                              photoUrls: photoUrls ?? [],
                                              likeCounts: item.likes.count,
                                              commentsCount: item.comments.count,
                                              repostCount: item.reposts.count,
                                              viewsCount: item.views?.count ?? 0)

            viewModels.append(viewModel)
        }

        return viewModels
    }
}
