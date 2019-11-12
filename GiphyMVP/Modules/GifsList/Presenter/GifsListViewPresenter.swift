//
//  GifsViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import Foundation

protocol GifsListViewPresenter {
    init(view: GifsListView, model: ModelLayer)
    func getTrending()
    func loadMore()
    func showDetails(for gif: Gif)
}
