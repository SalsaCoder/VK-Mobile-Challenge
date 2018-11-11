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
            let formatString : String = NSLocalizedString("newsfeed.totalCount", comment: "")
            let resultString : String = String.localizedStringWithFormat(formatString, postCount)

            label.text = resultString
        }
    }

    private var didSetupConstraints = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        if !didSetupConstraints {

            label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

            didSetupConstraints = true
        }

        super.updateConstraints()
    }
}
