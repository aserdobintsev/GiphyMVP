//
//  ModelLayer.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/11/19.
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
        loadTrendingFromServer(page: page, completionHandler:  completionHandler)
    }

    func save(with gif: Gif) {
        DispatchQueue.main.async { [weak self] in
            self?.dataLayer.performModify(object: gif, action: { realm in
                
            })
        }
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
                    // save new
                    let fromServer = self.translationLayer.toGifs(gyphs)
                    self.saveNew(fromServer)

                    let dbGifs = self.loadTrendingFromDB()
                    .sorted(by:) { l, r in
                        l.trending_datetime > r.trending_datetime
                    }
                    .filter { gif in
                        return fromServer.contains(where:) { serverGif in
                            return gif.id == serverGif.id
                        }
                    }
                    completionHandler(.success(dbGifs))
                }
            }
        }
    }

    private func saveNew(_ serverGifs:[Gif]) {
        let check = self.loadTrendingFromDB()
        let gifs = serverGifs.filter { gif in
            return !check.contains(where:) { dbgif in
                return gif.id == dbgif.id
            }
        }
        self.dataLayer.save(with: gifs)
    }

    private func loadTrendingFromDB() -> [Gif] {
        return dataLayer.load()
    }

//   private func syncFavourites() {
//        gifs.forEach { gif in
//            gif.favourite = self.profile.isFavouritGif(gif: gif)
//        }
//    }

}
