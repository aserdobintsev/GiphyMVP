//
//  GifDetailViewController.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/12/19.
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
