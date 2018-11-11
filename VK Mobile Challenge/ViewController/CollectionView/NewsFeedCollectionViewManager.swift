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
        return collectionView.bounds.size
    }
}
