//
//  UserProfile.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import RealmSwift

class UserProfile: Object {
    var favouriteGifs = List<Gif>()

    func isFavouritGif(gif: Gif) -> Bool {
        return !favouriteGifs.isEmpty && !favouriteGifs.allSatisfy { favouriteGif in
            return favouriteGif.id != gif.id
        }
    }
}
