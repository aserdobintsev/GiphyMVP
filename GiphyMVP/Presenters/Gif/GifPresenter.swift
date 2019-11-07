//
//  GifPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

class GifPresenter: GifViewPresenter {
    private unowned let view: GifViewProtocol
    private let gif: Gif

    required init(view: GifViewProtocol, gif: Gif) {
        self.view = view
        self.gif = gif
    }

    private var favouriteTitle: String {
        return gif.favourite ? "Remove from favourites" : "Add to favourites"
    }

    func load() {
        view.setTitle(gif.title)
        view.setFavouritTitle(favouriteTitle)
        // TODO: add gif placeholder
        loadImage()
    }

    private func loadImage() {
        guard let url = URL(string: gif.stillUrl) else {
            return
        }
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let imageData = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.view.setImageData(imageData)
            }
        }
    }

    func toggleFavourite() {
        gif.favourite.toggle()
        view.setFavouritTitle(favouriteTitle)
        // TODO save to Realm
    }
}
