//
//  NewsfeedTableViewCell.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedTableViewCell: UITableViewCell {
    private static let pageControlHeight: CGFloat = 39

    static let reuseIdentifier = "NewsfeedTableViewCell"

    private lazy var collectionViewManager: NewsFeedCollectionViewManager = {
        let manager = NewsFeedCollectionViewManager()
        manager.delegate = self

        return manager
    }()

    private var task: URLSessionDataTask?

    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControlHeightConstraint: NSLayoutConstraint!

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
            pageControl.isUserInteractionEnabled = false
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

        viewsLabel.text = viewModel.counters.views
        repostLabel.text = viewModel.counters.reposts
        commentsLabel.text = viewModel.counters.comments
        likesLabel.text = viewModel.counters.likes

        counterSeparator.isHidden = viewModel.photoUrls.count < 2

        pageControl.numberOfPages = viewModel.photoUrls.count
        collectionViewManager.photoUrls = viewModel.photoUrls

        task = profileImageView.setImage(with: viewModel.authorImageUrl)

        pageControlHeightConstraint.constant = viewModel.photoUrls.count > 1 ? NewsfeedTableViewCell.pageControlHeight : 0
        collectionViewHeightConstraint.constant = viewModel.photoUrls.count > 0 ? 150 : 0

        if let lineHeight = textView.font?.lineHeight {
            textView.text += "\nПоказать полностью..."
            textViewHeightConstraint.constant = lineHeight * 7
        }

        collectionView.reloadData()
    }
}

extension NewsfeedTableViewCell: NewsFeedCollectionViewManagerDelegate {
    func newsFeedCollectionViewManager(_ collectionViewManager: NewsFeedCollectionViewManager, didShowPhotoAt index: Int) {
        pageControl.currentPage = index
    }
}
