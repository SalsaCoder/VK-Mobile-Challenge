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
    private let maximumNumberOfLines = 6

    static let reuseIdentifier = "NewsfeedTableViewCell"

    private lazy var collectionViewManager: NewsFeedCollectionViewManager = {
        let manager = NewsFeedCollectionViewManager()
        manager.delegate = self

        return manager
    }()

    private var task: URLSessionDataTask?

    @IBOutlet weak var cvVerticalAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var cvHorizontalAspectRationConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewZeroHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControlHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textHeightConstraint: NSLayoutConstraint!


    @IBOutlet weak var showMoreButton: UIButton!
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
            textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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

    @IBAction func tapShowMoreButton(_ sender: Any) {

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        if let lineHeight = textView.font?.lineHeight {
//             Резервируем строки для кнопки "Показать полностью"
            textHeightConstraint.constant = lineHeight * CGFloat(maximumNumberOfLines + 2)
            showMoreButton.isHidden = false
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

        configureCounters(with: viewModel.counters)
        configureCollectionView(with: viewModel.photos)

        task = profileImageView.setImage(with: viewModel.authorImageUrl)
    }

    func configureCollectionView(with photos: [NewsfeedViewModel.PhotoViewModel]) {
        counterSeparator.isHidden = photos.count < 2
        pageControl.numberOfPages = photos.count
        collectionViewManager.photoUrls = photos.compactMap({ $0.url })

        pageControlHeightConstraint.constant = photos.count > 1 ? NewsfeedTableViewCell.pageControlHeight : 0
        collectionViewZeroHeightConstraint.isActive = photos.isEmpty

        // Если одна фотка и она вертикальная,
        // настраиваем констрейнты для вертикального отображения
        if photos.count == 1 {
            let photo = photos.first!
            if photo.width < photo.height {
                configureCollectionViewForVertical()
            }
        }

        collectionView.reloadData()
    }

    func configureCounters(with viewModel: NewsfeedViewModel.CountersViewModel) {
        viewsLabel.text = viewModel.views
        repostLabel.text = viewModel.reposts
        commentsLabel.text = viewModel.comments
        likesLabel.text = viewModel.likes
    }
}

extension NewsfeedTableViewCell: NewsFeedCollectionViewManagerDelegate {
    func newsFeedCollectionViewManager(_ collectionViewManager: NewsFeedCollectionViewManager, didShowPhotoAt index: Int) {
        pageControl.currentPage = index
    }
}

private extension NewsfeedTableViewCell {
    func configureCollectionViewForVertical() {
        cvHorizontalAspectRationConstraint.isActive = false
        cvVerticalAspectRatioConstraint.isActive = true
    }

    func configureCollectionViewForHorizontal() {
        cvHorizontalAspectRationConstraint.isActive = true
        cvVerticalAspectRatioConstraint.isActive = false
    }
}
