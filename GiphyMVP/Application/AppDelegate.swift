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

        navigationController = UINavigationController(rootViewController: configure())
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
        let modelLayer = ModelLayer(service: service, dataLayer: model)
        let view = GifsListViewController.fromStoryboard()
        let presenter = GifsListPresenter(view: view, model: modelLayer)
        view.presenter = presenter
        return view
    }

    func show(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
