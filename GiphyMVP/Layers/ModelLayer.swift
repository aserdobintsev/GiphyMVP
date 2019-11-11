//
//  ModelLayer.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/11/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation

enum LoadResult {
    case success([Gif])
    case failure
}

class ModelLayer {
    private let service: GiphyService
    private let dataLayer: DataLayer
    private let translationLayer: TranslationLayer

    init(service: GiphyService, dataLayer: DataLayer) {
        self.service = service
        self.dataLayer = dataLayer
        self.translationLayer = TranslationLayer()
    }

    func loadTrending(page: Int, completionHandler: @escaping (LoadResult) -> Void) {
        //loadTrendingFromDB()
        loadTrendingFromServer(page: page, completionHandler: completionHandler)
    }

    func save(with gif: Gif) {
        DispatchQueue.main.async { [weak self] in
            self?.dataLayer.performModify(object: gif, action: { realm in
                
            })
        }
    }

    private func loadTrendingFromDB() {
        
    }

    private func loadTrendingFromServer(page: Int, completionHandler: @escaping (LoadResult) -> Void) {
        service.getTrending(page: page) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch result {
                case .failure:
                    completionHandler(.failure)
                case .success(let gyphs):
                    let gifs = self.translationLayer.toGifs(gyphs)
                    self.dataLayer.save(with: gifs)
                    completionHandler(.success(gifs))
                }
            }
        }
    }
//   private func syncFavourites() {
//        gifs.forEach { gif in
//            gif.favourite = self.profile.isFavouritGif(gif: gif)
//        }
//    }

}
