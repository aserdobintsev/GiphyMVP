//
//  GiphyGif.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import Foundation

class GiphyGif: Decodable {
    var id: String
    var title: String
    var username: String
    var images: GiphyImages
    var trending_datetime: String
}

class GiphyImages: Decodable {
    var fixed_height: GiphyImageInfo
    var fixed_height_still: GiphyImageInfo
}

class GiphyImageInfo: Decodable {
    var height: String
    var width: String
    var url: String
}
