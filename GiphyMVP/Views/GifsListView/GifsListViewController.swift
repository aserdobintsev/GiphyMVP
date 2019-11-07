//
//  ViewController.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit

class GifsListViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    var presenter: GifsListViewPresenter!
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePullToRefresh()
        collectionView.delegate = self
        collectionView.dataSource = self
        presenter.getTrending()
    }

    private func configurePullToRefresh(){
        self.collectionView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }

    @objc
    private func refreshData() {
        presenter.getTrending()
    }
}

extension GifsListViewController: GifsListView {
    func startRefresh() {
        refreshControl.beginRefreshing()
    }

    func stopRefresh() {
        refreshControl.endRefreshing()
    }

    func updateGifs() {
        collectionView.reloadData()
    }

    func startLoadMore() {}

    func stopLoadMore() {}
}

extension GifsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO show details
        print("selected \(indexPath.row)")
    }
}

extension GifsListViewController: UICollectionViewDataSource {
    private var reuseIdentifier: String { "GifCellViewId" }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.gifs.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
          .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        if let cell = cell as? GifViewCell {
            cell.configure(with: presenter.gifs[indexPath.row])
        }
        return cell
    }
}

extension GifsListViewController : UICollectionViewDelegateFlowLayout {
    private var itemsPerRow: CGFloat {
        // TODO: change deprecated statusBarOrientation property
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            return 2
        default:
            return 1
        }
    }

    private var sectionInsets: UIEdgeInsets { UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0) }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = view.frame.width / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
  }

//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      insetForSectionAt section: Int) -> UIEdgeInsets {
//    return UIEdgeInsets.zero
//  }
//
//  func collectionView(_ collectionView: UICollectionView,
//                      layout collectionViewLayout: UICollectionViewLayout,
//                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//    return 0
//  }
}

extension GifsListViewController {
    static func fromStoryboard() -> GifsListViewController {
        guard let view = UIStoryboard(name: String(describing: GifsListViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? GifsListViewController
            else {
                fatalError("""
Can't load GifsViewController from storyboard,
check that controller is initial view controller
""")
        }
        return view
    }
}
