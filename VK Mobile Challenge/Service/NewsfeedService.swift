//
//  NewsfeedService.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

protocol NewsfeedServiceDelegate: class {
    func newsfeedService(_ service: NewsfeedService, didLoad newsfeed: Newsfeed)
    func newsfeedService(_ service: NewsfeedService, didFailWith error: Error)
}

final class NewsfeedService {
    weak var delegate: NewsfeedServiceDelegate?
    private let loader: Loader

    var accessToken: String?
    var startFrom: String?

    init(loader: Loader) {
        self.loader = loader
    }

    func loadNewsfeed() {
        guard accessToken != nil else {
            return
        }

        guard var urlComponents = URLComponents(string: Constants.URLs.newsfeed) else {
            return
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            return
        }

        let params = LoaderParams(url: url, resultType: APIResponse<Newsfeed>.self)
        _ = loader.load(params: params) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response):
                let newsfeed = response.response
                strongSelf.delegate?.newsfeedService(strongSelf, didLoad: newsfeed)

                break
            case .failure(let error):
                strongSelf.delegate?.newsfeedService(strongSelf, didFailWith: error)

                break
            }
        }

    }

    private var queryItems: [URLQueryItem] {
        var queryItems = [URLQueryItem(name: "filters", value: "post"),
                          URLQueryItem(name: "v", value: Constants.apiVersion),
                          URLQueryItem(name: "count", value: "20")]

        if let accessToken = accessToken {
            queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        }

        if let startFrom = startFrom {
            queryItems.append(URLQueryItem(name: "start_from", value: startFrom))
        }

        return queryItems
    }
}
