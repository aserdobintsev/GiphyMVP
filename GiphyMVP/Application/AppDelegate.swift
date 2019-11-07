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
        window.rootViewController = configure()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    // Assembling of MVP
    private func configure() -> UIViewController {
        let model = GiphyService()
        let view = GifsViewController.fromStoryboard()
        let presenter = GifsPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
