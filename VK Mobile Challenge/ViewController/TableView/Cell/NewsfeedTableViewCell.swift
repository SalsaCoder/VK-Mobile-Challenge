//
//  NewsfeedTableViewCell.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NewsfeedTableViewCell"

    let collectionViewManager = NewsFeedCollectionViewManager()

    var task: URLSessionDataTask?

    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
            profileImageView.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
        }
    }

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 10
            containerView.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var counterSeparator: UIView!

    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.hidesForSinglePage = true
        }
    }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = collectionViewManager
            collectionView.dataSource = collectionViewManager
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        profileImageView.image = nil
    }
}

extension NewsfeedTableViewCell {
    func configure(with viewModel: NewsfeedViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        textView.text = viewModel.text

        viewsLabel.text = viewModel.viewsCount > 0 ? "\(viewModel.viewsCount)" : nil
        repostLabel.text = viewModel.repostCount > 0 ? "\(viewModel.repostCount)" : nil
        commentsLabel.text = viewModel.commentsCount > 0 ? "\(viewModel.commentsCount)" : nil
        likesLabel.text = viewModel.likeCounts > 0 ? "\(viewModel.likeCounts)" : nil

        counterSeparator.isHidden = viewModel.photoUrls.count < 2

        pageControl.numberOfPages = viewModel.photoUrls.count
        collectionViewManager.imageUrls = viewModel.photoUrls

        task = profileImageView.setImage(with: viewModel.authorImageUrl)

        collectionView.reloadData()
    }
}
