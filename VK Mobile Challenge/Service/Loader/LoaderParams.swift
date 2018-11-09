//
//  LoaderParams.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 09/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import Foundation

struct LoaderParams<T: Decodable> {
    let url: URL
    let resultType: T.Type
}
