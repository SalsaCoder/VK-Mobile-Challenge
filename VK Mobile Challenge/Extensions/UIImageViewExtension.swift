//
//  UIImageViewExtension.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(with url: URL) -> URLSessionDataTask? {
        let session = URLSession.shared
        let cache = URLCache.shared
        let request = URLRequest(url: url)

        if let response = cache.cachedResponse(for: request) {
            image = UIImage(data: response.data)
            return nil
        }

        let task = session.dataTask(with: request) { [weak self] (data, _, error) in
            guard let strongSelf = self else {
                return
            }

            guard let imageData = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
                strongSelf.image = UIImage(data: imageData)
            }
        }

        task.resume()

        return task
    }
}
