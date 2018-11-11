//
//  CounterFooterView.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 12/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class CounterFooterView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center

        return label
    }()

    var postCount: Int = 0 {
        didSet {
            label.text = "\(postCount) записей"
        }
    }
}
