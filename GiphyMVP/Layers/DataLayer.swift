//
//  DataLayer.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation
import RealmSwift

class DataLayer {
    private let realm: Realm

    init() throws {
        realm = try Realm()
    }

    func performModify(object: Object, action: @escaping (Realm) -> Void) {
        if let realm = object.realm {
            try? realm.write {
                action(realm)
            }
        }
    }

    func save(with gifs: [Gif]) {
        try? realm.write {
            realm.add(gifs)
        }
    }
}
