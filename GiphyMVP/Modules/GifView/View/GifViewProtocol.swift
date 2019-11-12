//
//  GifViewProtocol.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//

import Foundation

protocol GifViewProtocol: class {
    func setTitle(_ title: String)
    func setGifData(_ gifData: Data)
    func setFavouritTitle(_ favouriteTitle: String)
}
