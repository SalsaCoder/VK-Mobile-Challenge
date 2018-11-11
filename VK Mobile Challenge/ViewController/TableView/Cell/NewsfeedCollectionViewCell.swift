//
//  NewsfeedCollectionViewCell.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 11/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private var task: URLSessionTask?

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)
        imageView.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with url: URL) {
        task = imageView.setImage(with: url)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        imageView.image = nil
    }
}
