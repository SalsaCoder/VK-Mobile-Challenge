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
    let tableViewManager = NewsfeedTableViewManager()

    let authService = AuthService()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager

        authService.delegate = self
        newsfeedService.delegate = self

        authService.requestAuthorization()

        setupBackgroundView()
    }

    private func setupBackgroundView() {
        let layer = Constants.Colors.grayGradientLayer
        layer.frame = tableView.bounds

        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(layer, at: 0)
        tableView.backgroundView = backgroundView
    }
}

extension NewsfeedTableViewController: NewsfeedServiceDelegate {
    func newsfeedService(_ service: NewsfeedService, didLoad newsfeed: Newsfeed) {
        tableViewManager.viewModels = viewModelBuilder.buildViewModels(from: newsfeed)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func newsfeedService(_ service: NewsfeedService, didFailWith error: Error) {
        print(error)
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
