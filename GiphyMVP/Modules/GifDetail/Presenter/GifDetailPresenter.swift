//
//  GifDetailPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/12/19.
//

import Foundation

class GifDetailPresenter: GifDetailViewPresenter {
    private unowned let view: GifDetailView
    private let gif: Gif

    required init(view: GifDetailView, gif: Gif) {
        self.view = view
        self.gif = gif
    }

    func load() {
        self.view.configure(with: gif)
    }
}
