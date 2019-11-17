//
//  AppDelegate.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let configurator = GifListConfigurator()
        navigationController = UINavigationController(rootViewController: configurator.configure())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    func show(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
