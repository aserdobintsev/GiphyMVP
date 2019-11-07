//
//  GifsViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

protocol GifsViewPresenter {
    init(view: GifsView, model: GiphyService)
    func getTrending()
    var gifs: [Gif] { get }
}
