//
//  GifPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//

import Foundation
import RealmSwift

class GifPresenter: GifViewPresenter {
    private weak var view: GifViewProtocol?
    private let gif: Gif

    private var modelNotificationToken: NotificationToken?
    private var isSubscribedToModel: Bool {
        return modelNotificationToken != nil
    }

    required init(view: GifViewProtocol, gif: Gif) {
        self.view = view
        self.gif = gif
    }

    deinit {
        modelNotificationToken?.invalidate()
    }

    private func onChange(change: ObjectChange) {
        switch change {
        case .change(_):
            updateUI()
        default:
            // do nothing
            break
        }
    }

    private var favouriteTitle: String {
        return gif.favourite ? L10n.GifView.removeFromFavourite : L10n.GifView.addToFavourite
    }

    func getData() {
        if !isSubscribedToModel {
            modelNotificationToken = gif.observe(self.onChange(change:))
        }
        updateUI()
        updateGifData()
    }

    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.setTitle(self.gif.title)
            self.view?.setFavouritTitle(self.favouriteTitle)
        }
    }

    private func updateGifData() {
        guard let gifData = gif.gifData else {
            loadGif()
            return
        }
        self.view?.setGifData(gifData)
    }

    private func loadGif() {
        guard let url = URL(string: gif.url) else {
            return
        }
        DispatchQueue.global(qos: .default).async {
            guard let gifData = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.saveGif(with: gifData)
                self.view?.setGifData(gifData)
            }
        }
    }

    private func saveGif(with data: Data) {
        // TODO realm exposure
        try? gif.realm?.write {
            gif.gifData = data
        }
    }

    func toggleFavourite() {
        // TODO check saving
        /*
         model.performModify(object: profile) { [weak self] realm in
             realm.add(gif)
             self?.profile.favouriteGifs.append(gif)
         }
         */

        //TODO realm exposure
        try? gif.realm?.write {
            gif.favourite.toggle()
        }
    }
}
