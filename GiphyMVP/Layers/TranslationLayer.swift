//
//  TranslationLayer.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

class TranslationLayer {
    func toGifs(_ gyphyGifs: [GiphyGif]) -> [Gif] {
        return gyphyGifs.map { gyphy in
            let gif = Gif()
            gif.id = gyphy.id
            gif.title = gyphy.title
            gif.url = gyphy.images.fixed_height.url
            gif.stillUrl = gyphy.images.fixed_height_still.url
            gif.height = Int(gyphy.images.fixed_height.height) ?? 0
            gif.width = Int(gyphy.images.fixed_height.width) ?? 0
            return gif
        }
    }
}
