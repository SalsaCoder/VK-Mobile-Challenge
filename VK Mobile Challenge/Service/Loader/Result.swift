//
//  Result.swift
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
