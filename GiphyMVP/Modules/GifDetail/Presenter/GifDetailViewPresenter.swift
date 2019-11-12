//
//  GifDetailViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/12/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

protocol GifDetailViewPresenter {
    init(view: GifDetailView, gif: Gif)
    func load()
}
