//
//  GiphyResponse.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

class GiphyResponse: Decodable {
    var data: [GiphyGif]
    var pagination: GiphyPagination
    var meta: GiphyMeta
}
