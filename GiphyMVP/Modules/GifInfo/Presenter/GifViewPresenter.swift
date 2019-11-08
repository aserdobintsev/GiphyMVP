//
//  GifViewPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation

protocol GifViewPresenter {
    init(view: GifViewProtocol, gif: Gif, toggleAction: @escaping (Gif) -> Void)
    func getData()
    func toggleFavourite()
}
