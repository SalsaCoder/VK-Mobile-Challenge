//
//  NewsFeedCollectionViewManager.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 11/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

protocol NewsFeedCollectionViewManagerDelegate: class {
    func newsFeedCollectionViewManager(_ collectionViewManager: NewsFeedCollectionViewManager, didShowPhotoAt index: Int)
}

final class NewsFeedCollectionViewManager: NSObject {
    weak var delegate: NewsFeedCollectionViewManagerDelegate?
    var imageUrls: [URL] = []
}

extension NewsFeedCollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsfeedCollectionViewCell.reuseIdentifier, for: indexPath)

        if let cell = cell as? NewsfeedCollectionViewCell {
            let url = imageUrls[indexPath.row]
            cell.configure(with: url)
        }

        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
}

extension NewsFeedCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collectionView.bounds.size

        if imageUrls.count == 1 {
            return size
        }

        size.width -= 12 * 2

        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if imageUrls.count == 1 {
            return .zero
        }

        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if imageUrls.count == 1 {
            return 0
        }

        return 4
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2),
                             y: (scrollView.frame.height / 2))

        guard let indexPath = (scrollView as? UICollectionView)?.indexPathForItem(at: center) else {
            return
        }

        delegate?.newsFeedCollectionViewManager(self, didShowPhotoAt: indexPath.row)
    }
}
