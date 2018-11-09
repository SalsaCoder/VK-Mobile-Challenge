//
//  UserInfoService.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

protocol UserInfoServiceDelegate: class {
    func userInfoService(_ service: UserInfoService, didLoad user: User)
    func userInfoService(_ service: UserInfoService, didFailWith error: Error)

}

final class UserInfoService {
    weak var delegate: UserInfoServiceDelegate?

    let loader: Loader

    var userId = ""
    var accessToken = ""

    init(loader: Loader) {
        self.loader = loader
    }

    func loadUserInfo() {
        guard var urlComponents = URLComponents(string: Constants.URLs.users) else {
            return
        }

        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            return
        }

        let params = LoaderParams(url: url, resultType: APIResponse<[User]>.self)
        _ = loader.load(params: params) { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response):
                guard let user = response.response.first else {
                    return
                }
                strongSelf.delegate?.userInfoService(strongSelf, didLoad: user)

                break
            case .failure(let error):
                strongSelf.delegate?.userInfoService(strongSelf, didFailWith: error)

                break
            }
        }
    }

    private var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "fields[]", value: "photo_50"),
                URLQueryItem(name: "user_id", value: userId),
                URLQueryItem(name: "access_token", value: accessToken),
                URLQueryItem(name: "v", value: Constants.apiVersion)]
    }
}
