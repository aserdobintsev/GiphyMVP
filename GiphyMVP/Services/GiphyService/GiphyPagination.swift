//
//  GiphyPagination.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import Foundation

class GiphyPagination: Decodable {
    var offset: Int
    var count: Int
    var total_count: Int
}
