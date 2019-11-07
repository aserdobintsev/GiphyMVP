//
//  GifsPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

class GifsPresenter: GifsViewPresenter {
    private  unowned let view: GifsView
    private  let model: GiphyService

    var gifs = [Gif]()

    private var currentPage = 0

    required init(view: GifsView, model: GiphyService) {
        self.view = view
        self.model = model
    }

    func getTrending() {
        currentPage = 0
        loadTrending(with: currentPage)
    }

    func loadMore() {
        currentPage += 1
        loadTrending(with: currentPage)
    }

    private func loadTrending(with page: Int) {
        view.startLoading()
        model.trending(page: page) { [weak self] gyphs in
            guard let self = self else {
                return
            }
            self.gifs.append(contentsOf: self.toGifs(gyphs))
            DispatchQueue.main.async { [weak self] in
                self?.view.stopLoading()
                self?.view.updateGifs()
            }
        }
    }

    func toGifs(_ gyphyGifs: [GiphyGif]) -> [Gif] {
        return gyphyGifs.map { gyphy in
            let gif = Gif()
            gif.id = gyphy.id
            gif.title = gyphy.title
            gif.url = gyphy.images.fixed_height.url
            gif.stillUrl = gyphy.images.fixed_height_still.url
            gif.height = Int(gyphy.images.fixed_height.height) ?? 0
            gif.width = Int(gyphy.images.fixed_height.width) ?? 0
            return gif
        }
    }
}
