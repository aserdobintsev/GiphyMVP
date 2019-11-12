//
//  GifViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//

import Foundation

protocol GifViewPresenter {
    init(view: GifViewProtocol, gif: Gif)
    func getData()
    func toggleFavourite()
}
