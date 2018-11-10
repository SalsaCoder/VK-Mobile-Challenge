//
//  NewsfeedTableViewManager.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedTableViewManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    var viewModels = [NewsfeedViewModel]()

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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
