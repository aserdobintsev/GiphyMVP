//
//  GifViewProtocol.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

protocol GifViewProtocol: class {
    func setTitle(_ title: String)
    func setImageData(_ imageData: Data)
    func setFavouritTitle(_ favouriteTitle: String)
}
