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

final class Loader {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func load<T: Decodable>(request: URLRequest, completion: ((Result<T>) -> Void)?) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion?(.failure(error))
                return
            }

            // TODO: проверить коды

            if let data = data {
                let decoder = JSONDecoder()

                do {
                    let data = try decoder.decode(T.self, from: data)
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
