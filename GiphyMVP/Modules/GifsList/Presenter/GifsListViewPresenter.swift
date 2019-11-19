//
//  GifsViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import Foundation

protocol GifsListViewPresenter: class {
    init(view: GifsListView, model: ModelLayer)
    func getTrending()
    func loadMore()
    func showDetails(for gif: Gif)
}

protocol GifListPresenterDelegate: class {
    func didSelect(gif: Gif)
}
