//
//  GifsPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

class GifsListPresenter: GifsListViewPresenter {
    private  unowned let view: GifsListView
    private  let model: GiphyService

    var gifs = [Gif]()

    private var currentPage = 0

    required init(view: GifsListView, model: GiphyService) {
        self.view = view
        self.model = model
    }

    func getTrending() {
        currentPage = 0
        view.startRefresh()
        model.trending(page: currentPage) { [weak self] gyphs in
            guard let self = self else {
                return
            }
            self.gifs.removeAll()
            self.gifs.append(contentsOf: self.toGifs(gyphs))
            DispatchQueue.main.async { [weak self] in
                self?.view.stopRefresh()
                self?.view.updateGifs()
            }
        }
    }

    func loadMore() {
        currentPage += 1
        view.startLoadMore()
         model.trending(page: currentPage) { [weak self] gyphs in
                   guard let self = self else {
                       return
                   }
                   self.gifs.append(contentsOf: self.toGifs(gyphs))
                   DispatchQueue.main.async { [weak self] in
                       self?.view.stopLoadMore()
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
