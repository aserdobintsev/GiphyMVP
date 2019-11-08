//
//  GifPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation

class GifPresenter: GifViewPresenter {
    private unowned let view: GifViewProtocol
    private let gif: Gif
    private let toggleAction: (Gif) -> Void

    required init(view: GifViewProtocol, gif: Gif, toggleAction: @escaping (Gif) -> Void) {
        self.view = view
        self.gif = gif
        self.toggleAction = toggleAction
    }

    private var favouriteTitle: String {
        return gif.favourite ? L10n.Gifview.removeFromFavourite : L10n.Gifview.addToFavourite
    }

    func getData() {
        view.setTitle(gif.title)
        view.setFavouritTitle(favouriteTitle)
        loadGif()
    }

    private func loadGif() {
        guard let url = URL(string: gif.url) else {
            return
        }
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let gifData = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.view.setGifData(gifData)
            }
        }
    }

    func toggleFavourite() {
        toggleAction(gif)
    }
}
