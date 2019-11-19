//
//  GifListCoordinator.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/18/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

class GifListCoordinator: Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        let configurator = GifListConfigurator()
        let view = configurator.configure(with: self)
        navigationController.viewControllers = [view]
    }
}

extension GifListCoordinator: GifListPresenterDelegate {
    func didSelect(gif: Gif) {
        let configurator = GifDetailConfigurator()
        let view = configurator.configure(with: gif)
        navigationController.pushViewController(view, animated: true)
    }
}
