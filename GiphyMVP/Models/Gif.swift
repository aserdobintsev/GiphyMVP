//
//  Gif.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import Foundation
import RealmSwift

class Gif: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var favourite: Bool = false
    @objc dynamic var trending_datetime: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var gifData: Data?
    @objc dynamic var stillUrl: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
