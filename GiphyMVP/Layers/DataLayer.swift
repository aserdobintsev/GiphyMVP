//
//  DataLayer.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import RealmSwift

class DataLayer {
    private let realmRead: Realm
    private var realmWrite: Realm?
    private let realmWriteQueue: DispatchQueue
    init() throws {
        realmRead = try Realm()

        realmWriteQueue = DispatchQueue(label: "realm")
        realmWriteQueue.async { [weak self] in
            self?.realmWrite = try? Realm()
        }
    }

    func getUserProfile() -> UserProfile {
        if let savedProfile = realmRead.objects(UserProfile.self).first {
            return savedProfile
        }
        let userProfile = UserProfile()
        save(with: userProfile)
        return userProfile
    }

    private func save(with userProfile: UserProfile) {
        realmWriteQueue.async { [weak self] in
            try? self?.realmWrite?.write {
                self?.realmWrite?.add(userProfile)
            }
        }
    }

    func performModify(object: Object,action: @escaping (Realm) -> Void) {
        if let realm = object.realm {
            try? realm.write {
                action(realm)
            }
        }
    }
}
