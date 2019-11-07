//
//  GifsView.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

protocol GifsListView: class {
    func startRefresh()
    func stopRefresh()

    func startLoadMore()
    func stopLoadMore()

    func updateGifs()
}
