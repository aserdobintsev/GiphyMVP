//
//  GifsView.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation

protocol GifsListView: class {
    func startRefresh()
    func stopRefresh()

    func startLoadMore()
    func stopLoadMore()

    func update(with gifs: [Gif])
    func networkErrorOccured()
}
