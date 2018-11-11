//
//  NewsfeedTableViewManager.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedTableViewManager: NSObject {
    var viewModels = [NewsfeedViewModel]()
    let tableView: UITableView

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.frame = CGRect(x: 0, y: 0, width: 0, height: 44)

        return indicator
    }()

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }

    var showLoadingIndicator: Bool = false {
        didSet {
            if showLoadingIndicator {
                tableView.tableFooterView = loadingIndicator
                loadingIndicator.startAnimating()
            } else {
                tableView.tableFooterView = UIView()
                loadingIndicator.stopAnimating()
            }
        }
    }
}

extension NewsfeedTableViewManager: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedTableViewCell.reuseIdentifier, for: indexPath)

        if let cell = cell as? NewsfeedTableViewCell {
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
