//
//  GifsPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation
import RealmSwift

class GifsListPresenter: GifsListViewPresenter {
    private unowned let view: GifsListView
    private let model: DataLayer
    private let profile: UserProfile
    private let service: GiphyService
    private let translation: TranslationLayer
    private var modelNotificationToken: NotificationToken?
    private var isSubscribedToModel: Bool {
        return modelNotificationToken != nil
    }
    var gifs = [Gif]()

    private var currentPage = 0

    required init(view: GifsListView, model: DataLayer, service: GiphyService) {
        self.view = view
        self.model = model
        self.service = service
        self.profile = self.model.getUserProfile()
        self.translation = TranslationLayer()
    }

    deinit {
        modelNotificationToken?.invalidate()
    }

    private func subscribe(with profile: UserProfile) -> NotificationToken {
        return profile.favouriteGifs.observe { [weak self] (changes: RealmCollectionChange<List<Gif>>) in
            guard let self = self else {
                return
            }
            switch changes {
            case .update(_, deletions: _, insertions: _, modifications: _):
                DispatchQueue.main.async {
                    self.syncFavourites()
                }
            default:
                // do nothing
                break
            }
        }
    }

    private func syncFavourites() {
        gifs.forEach { gif in
            gif.favourite = self.profile.isFavouritGif(gif: gif)
        }
    }

    private func onFavouritesChange(changes: RealmCollectionChange<List<Gif>>) {
        switch changes {
        case .update(_, deletions: _, insertions: _, modifications: _):
            DispatchQueue.main.async {
                self.syncFavourites()
                self.view.updateGifs()
            }
        default:
            // do nothing
            break
        }
    }

    func getTrending() {
        if !isSubscribedToModel {
            modelNotificationToken = self.profile.favouriteGifs.observe(self.onFavouritesChange(changes:))
        }

        currentPage = 0
        view.startRefresh()
        service.getTrending(page: currentPage) { result in
            DispatchQueue.main.sync { [weak self] in
                guard let self = self else {
                    return
                }
                self.view.stopRefresh()

                switch result {
                case .failure:
                self.view.updateGifs()
                self.view.networkErrorOccured()
                case .success(let gyphs):
                    self.gifs.removeAll()
                    self.gifs.append(contentsOf: self.translation.toGifs(gyphs))
                    self.syncFavourites()
                    self.view.updateGifs()
                }

            }
        }
    }

    func loadMore() {
        currentPage += 1
        view.startLoadMore()
        service.getTrending(page: currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.view.stopLoadMore()

                switch result {
                case .failure:
                    self.view.networkErrorOccured()
                case .success(let gyphs):
                    self.gifs.append(contentsOf: self.translation.toGifs(gyphs))
                    self.syncFavourites()
                    self.view.updateGifs()
                }
            }
        }
    }

    func toggleFavourite(gif: Gif) {
        if profile.isFavouritGif(gif: gif) {
            if let index = profile.favouriteGifs.firstIndex(where: { favouriteGif in
                return favouriteGif.id == gif.id
            }) {
                model.performModify(object: profile) { [weak self] realm in
                    let toDeleteGif = self?.profile.favouriteGifs[index]
                    self?.profile.favouriteGifs.remove(at: index)
                    if let gifToDelete = toDeleteGif {
                        realm.delete(gifToDelete)
                    }
                }
            }
        } else {
            model.performModify(object: profile) { [weak self] realm in
                realm.add(gif)
                self?.profile.favouriteGifs.append(gif)
            }
        }
    }
}
