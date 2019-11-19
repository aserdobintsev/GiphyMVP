//
//  GifDetailConfigurator.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/19/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

final class GifDetailConfigurator {
    func configure(with gif: Gif) -> UIViewController {
        guard let view = UIStoryboard(name: String(describing: GifDetailViewController.self),
                                      bundle: Bundle.main)
            .instantiateInitialViewController() as? GifDetailViewController
            else {
                fatalError("""
               Can't load GifDetailViewController from storyboard,
               check that controller is initial view controller
               """)
        }
        let presenter = GifDetailPresenter(view: view, gif: gif)
        view.presenter = presenter
        return view
    }
}
