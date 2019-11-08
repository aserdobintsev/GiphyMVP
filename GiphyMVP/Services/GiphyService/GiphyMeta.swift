//
//  GiphyMeta.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation

class GiphyMeta: Decodable {
    var status: Int
    var msg: String
    var response_id: String
}
