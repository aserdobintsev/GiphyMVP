//
//  GifDetailViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/12/19.
//

import Foundation

protocol GifDetailViewPresenter {
    init(view: GifDetailView, gif: Gif)
    func load()
}
