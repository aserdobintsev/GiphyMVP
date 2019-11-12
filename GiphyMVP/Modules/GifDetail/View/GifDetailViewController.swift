//
//  GifDetailViewController.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/12/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit

class GifDetailViewController: UIViewController {

    @IBOutlet private weak var gifView: GifView!

    var presenter: GifDetailViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
    }
}

extension GifDetailViewController: GifDetailView {
    func configure(with gif: Gif) {
        let gifViewPresenter = GifPresenter(view: gifView, gif: gif)
        gifView.configure(with: gifViewPresenter)
    }
}

extension GifDetailViewController {
    static func fromStoryboard() -> GifDetailViewController {
        guard let view = UIStoryboard(name: String(describing: GifDetailViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? GifDetailViewController
            else {
                fatalError("""
Can't load GifDetailViewController from storyboard,
check that controller is initial view controller
""")
        }
        return view
    }
}
