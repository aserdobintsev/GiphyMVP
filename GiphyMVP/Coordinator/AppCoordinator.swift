//
//  AppCoordinator.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/18/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    private let window: UIWindow = UIWindow()
    private let navigationController = UINavigationController()
    private var starterCoordinator: Coordinator?
    init() {
        setup()
        setupStarter()
    }

    private func setup() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func setupStarter() {
        starterCoordinator = GifListCoordinator(navigationController: navigationController)
    }

    func start() {
        starterCoordinator?.start()
    }
}
