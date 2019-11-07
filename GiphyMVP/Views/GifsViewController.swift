//
//  ViewController.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit

class GifsViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!

    var presenter: GifsViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        presenter.getTrending()
    }
}

extension GifsViewController: GifsView {
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func stopLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    func updateGifs() {
        collectionView.reloadData()
    }
}

extension GifsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO show details
        print("selected \(indexPath.row)")
    }
}

extension GifsViewController: UICollectionViewDataSource {
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

extension GifsViewController : UICollectionViewDelegateFlowLayout {
    private var itemsPerRow: CGFloat {
        // TODO: change deprecated statusBarOrientation property
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            return 2
        default:
            return 1
        }
    }
    private var sectionInsets: UIEdgeInsets { UIEdgeInsets.zero }
    //    private var sectionInsets: UIEdgeInsets { UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0) }

  //1
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  // 4
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension GifsViewController {
    static func fromStoryboard() -> GifsViewController {
        guard let view = UIStoryboard(name: String(describing: GifsViewController.self),
                                      bundle: Bundle.main).instantiateInitialViewController() as? GifsViewController
            else {
                fatalError("""
Can't load GifsViewController from storyboard,
check that controller is initial view controller
""")
        }
        return view
    }
}
