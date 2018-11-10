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

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!

    @IBAction func tapShowMoreButton(_ sender: UIButton) {
    }

    func configure(with viewModel: NewsfeedViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        textView.text = viewModel.text

        let sizeThatFitsTextView = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat(MAXFLOAT)))
        let heightOfText = sizeThatFitsTextView.height
        textViewHeightConstraint.constant = heightOfText
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
}
