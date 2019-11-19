//
//  GifListConfigurator.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/17/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

final class GifListConfigurator {
    func configure(with delegate: GifListPresenterDelegate) -> UIViewController {
        guard let model = try? DataLayer() else {
            fatalError()
        }
        guard let view = UIStoryboard(name: String(describing: GifsListViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? GifsListViewController
                    else {
                        fatalError("""
        Can't load GifsViewController from storyboard,
        check that controller is initial view controller
        """)
        }
        let service = GiphyService()
        let modelLayer = ModelLayer(service: service, dataLayer: model)
        let presenter = GifsListPresenter(view: view, model: modelLayer)
        presenter.delegate = delegate
        view.presenter = presenter
        return view
    }
}
