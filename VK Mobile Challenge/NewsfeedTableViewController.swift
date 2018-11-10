//
//  NewsfeedTableViewController.swift
//  VK Mobile Challenge
//
//  Created by Ilya Gluschuk on 10/11/2018.
//  Copyright © 2018 Ilya Glushchuk. All rights reserved.
//

import UIKit

final class NewsfeedTableViewController: UITableViewController {
    let viewModelBuilder = NewsfeedViewModelBuilder()
    let newsfeedService = NewsfeedService(loader: Loader(session: URLSession.shared))

    var viewModels = [NewsfeedViewModel]()

    let authService = AuthService()

    override func viewDidLoad() {
        super.viewDidLoad()

        authService.delegate = self
        newsfeedService.delegate = self

        authService.requestAuthorization()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedTableViewCell.reuseIdentifier, for: indexPath)

        if let cell = cell as? NewsfeedTableViewCell {
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension NewsfeedTableViewController: NewsfeedServiceDelegate {
    func newsfeedService(_ service: NewsfeedService, didLoad newsfeed: Newsfeed) {
        viewModels = viewModelBuilder.buildViewModels(from: newsfeed)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func newsfeedService(_ service: NewsfeedService, didFailWith error: Error) {

    }
}

extension NewsfeedTableViewController: AuthServiceDelegate {
    func authService(_ authService: AuthService, didAuthorizeWith token: Token) {
        newsfeedService.accessToken = token.accessToken
        newsfeedService.loadNewsfeed()
    }

    func authServiceDidFail(_ authService: AuthService) {

    }
}
