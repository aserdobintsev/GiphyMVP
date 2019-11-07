//
//  GifViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

protocol GifViewPresenter {
    init(view: GifViewProtocol, gif: Gif)
    func load()
    func toggleFavourite()
}
