//
//  NewsfeedCollectionViewCell.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 11/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "NewsfeedCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private var task: URLSessionTask?
    private var didSetupConstraints = false

    override func awakeFromNib() {
        super.awakeFromNib()

        addSubview(imageView)
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        if !didSetupConstraints {
            imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

            didSetupConstraints = true
        }

        super.updateConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        imageView.image = nil
    }
}

extension NewsfeedCollectionViewCell {
    func configure(with url: URL) {
        task = imageView.setImage(with: url)
    }
}
