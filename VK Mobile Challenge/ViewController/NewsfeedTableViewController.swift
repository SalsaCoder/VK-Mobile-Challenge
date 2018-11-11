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

    var lastNextFrom: String?
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewManager.delegate = self

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
        let viewModels = viewModelBuilder.buildViewModels(from: newsfeed)
        tableViewManager.viewModels.append(contentsOf: viewModels)

        lastNextFrom = newsfeed.nextFrom
        isLoading = false
        
        DispatchQueue.main.async {
            self.tableViewManager.showLoadingIndicator = false
            self.tableView.reloadData()
        }
    }

    func newsfeedService(_ service: NewsfeedService, didFailWith error: Error) {
        print(error)
        isLoading = false
        tableViewManager.showLoadingIndicator = true
    }
}

extension NewsfeedTableViewController: AuthServiceDelegate {
    func authService(_ authService: AuthService, didAuthorizeWith token: Token) {
        newsfeedService.accessToken = token.accessToken

        tableViewManager.showLoadingIndicator = true
        isLoading = true
        newsfeedService.loadNewsfeed()
    }

    func authServiceDidFail(_ authService: AuthService) {

    }
}

extension NewsfeedTableViewController: NewsfeedTableViewManagerDelegate {
    func newsfeedTableViewManagerWillScrollToEnd(_ manager: NewsfeedTableViewManager) {
//        guard !isLoading && lastNextFrom != nil  else {
//            return
//        }
//
//        isLoading = true
//        newsfeedService.startFrom = lastNextFrom
//        newsfeedService.loadNewsfeed()
//        tableViewManager.showLoadingIndicator = true
    }
}
