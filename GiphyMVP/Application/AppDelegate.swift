//
//  AppDelegate.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()

        let navigationController = UINavigationController(rootViewController: configure())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    private func configure() -> UIViewController {
        guard let model = try? DataLayer() else {
            fatalError()
        }

        let service = GiphyService()
        let view = GifsListViewController.fromStoryboard()
        let presenter = GifsListPresenter(view: view, model: model, service: service)
        view.presenter = presenter
        return view
    }
}
