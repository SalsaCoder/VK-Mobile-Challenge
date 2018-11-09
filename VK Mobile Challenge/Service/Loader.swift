//
//  Loader.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

struct LoaderParams<T: Decodable> {
    let url: URL
    let resultType: T.Type
}

final class Loader {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func load<T>(params: LoaderParams<T>, completion: ((Result<T>) -> Void)?) -> URLSessionDataTask {
        let task = session.dataTask(with: params.url) { (data, response, error) in
            if let error = error {
                completion?(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    return
                }
            }

            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let data = try decoder.decode(params.resultType, from: data)
                    completion?(.success(data))
                } catch {
                    completion?(.failure(error))
                }
            }
        }

        task.resume()
        return task
    }
}
