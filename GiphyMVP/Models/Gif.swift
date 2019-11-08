//
//  Gif.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation
import RealmSwift

class Gif: Object {
    @objc dynamic var id: String = ""
    var favourite: Bool = false
    var title: String = ""
    var height: Int = 0
    var width: Int = 0
    var url: String = ""
    var stillUrl: String = ""
}
