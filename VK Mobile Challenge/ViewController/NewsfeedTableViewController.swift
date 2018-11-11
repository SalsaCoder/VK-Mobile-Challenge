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
    lazy var tableViewManager = NewsfeedTableViewManager(tableView: tableView)
    let authService = AuthService()

    private var state = NewsfeedTableViewControllerState()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBackgroundView()
        setupRefreshControl()

        authService.delegate = self
        newsfeedService.delegate = self

        authService.requestAuthorization()
    }

    private func setupTableView() {
        tableViewManager.delegate = self
        tableViewManager.showLoadingIndicator = true

        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        tableView.estimatedRowHeight = 300
    }

    private func setupBackgroundView() {
        let layer = Constants.Colors.grayGradientLayer
        layer.frame = tableView.bounds

        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(layer, at: 0)
        tableView.backgroundView = backgroundView
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .lightGray
        refreshControl?.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
    }

    @objc func refreshFeed() {
        state.lastNextFrom = nil
        newsfeedService.startFrom = nil
        state.isReloading = true
        newsfeedService.loadNewsfeed()
    }
}

extension NewsfeedTableViewController: NewsfeedServiceDelegate {
    func newsfeedService(_ service: NewsfeedService, didLoad newsfeed: Newsfeed) {
        DispatchQueue.main.async {
            if self.refreshControl?.isRefreshing ?? false {
                self.refreshControl?.endRefreshing()
            }

            let viewModels = self.viewModelBuilder.buildViewModels(from: newsfeed, viewWidth: self.view.bounds.width)
            if self.state.isReloading {
                self.tableViewManager.viewModels = viewModels
            } else {
                self.tableViewManager.viewModels.append(contentsOf: viewModels)
            }


            self.state.lastNextFrom = newsfeed.nextFrom
            self.state.isLoading = false
            self.state.isReloading = false

            self.tableViewManager.showLoadingIndicator = false
            self.tableView.reloadData()
        }
    }

    func newsfeedService(_ service: NewsfeedService, didFailWith error: Error) {
        print(error)
        state.isLoading = false
        tableViewManager.showLoadingIndicator = false
    }
}

extension NewsfeedTableViewController: AuthServiceDelegate {
    func authService(_ authService: AuthService, didAuthorizeWith token: Token) {
        newsfeedService.accessToken = token.accessToken

        tableViewManager.showLoadingIndicator = true
        state.isLoading = true
        newsfeedService.loadNewsfeed()
    }

    func authServiceDidFail(_ authService: AuthService) {
    }
}

extension NewsfeedTableViewController: NewsfeedTableViewManagerDelegate {
    func newsfeedTableViewManagerWillScrollToEnd(_ manager: NewsfeedTableViewManager) {
        guard !state.isLoading && state.lastNextFrom != nil  else {
            return
        }

        state.isLoading = true
        newsfeedService.startFrom = state.lastNextFrom
        newsfeedService.loadNewsfeed()

        tableViewManager.showLoadingIndicator = true
    }
}
