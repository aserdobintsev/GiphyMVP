//
//  GifDetailView.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/12/19.
//

import Foundation

protocol GifDetailView: class {
    func configure(with gif: Gif)
}
