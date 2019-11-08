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

    func getUserProfile() -> UserProfile {
        if let savedProfile = realm.objects(UserProfile.self).first {
            return savedProfile
        }
        let userProfile = UserProfile()
        try? realm.write {
            realm.add(userProfile)
        }
        return userProfile
    }

    func performModify(object: Object, action: @escaping (Realm) -> Void) {
        if let realm = object.realm {
            try? realm.write {
                action(realm)
            }
        }
    }
}
