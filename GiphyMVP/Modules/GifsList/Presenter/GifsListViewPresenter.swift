//
//  GifsViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation

protocol GifsListViewPresenter {
    init(view: GifsListView, model: ModelLayer)
    func getTrending()
    func loadMore()
}
