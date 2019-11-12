//
//  GifsPresenter.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import Foundation
import RealmSwift

class GifsListPresenter: GifsListViewPresenter {
    private unowned let view: GifsListView
    private let model: ModelLayer

    var gifs = [Gif]()

    private var currentPage = 0

    required init(view: GifsListView, model: ModelLayer) {
        self.view = view
        self.model = model
    }
    
    func getTrending() {
        currentPage = 0
        view.startRefresh()
        model.loadTrending(page: currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.view.stopRefresh()
                switch result {
                case .failure:
                    self.view.networkErrorOccured()
                case .success(let newGifs):
                    self.gifs.removeAll()
                    self.gifs.append(contentsOf: newGifs)
                    self.view.update(with: self.gifs)
                }
            }
        }
    }

    func loadMore() {
        currentPage += 1
        view.startLoadMore()
        model.loadTrending(page: currentPage) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.view.stopLoadMore()
                switch result {
                case .failure:
                    self.view.networkErrorOccured()
                case .success(let gifs):
                    self.gifs.append(contentsOf: gifs)
                    self.view.update(with: self.gifs)
                }
            }
        }
    }

    func showDetails(for gif: Gif) {
        // TODO: extract construction and navigation logic to Router/Coordinator
        let view = GifDetailViewController.fromStoryboard()
        let presenter = GifDetailPresenter(view: view, gif: gif)
        view.presenter = presenter
        // TODO: bad practice, temporarily here
        (UIApplication.shared.delegate as? AppDelegate)?.show(view: view)
    }
}
