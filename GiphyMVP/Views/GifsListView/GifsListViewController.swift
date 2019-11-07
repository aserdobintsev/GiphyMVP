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
    private var footerRefreshControl: FooterRefreshControl?

    var presenter: GifsListViewPresenter!
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        configurePullToRefresh()
        configurePagination()

        presenter.getTrending()
    }

    private func configurePullToRefresh() {
        self.collectionView.alwaysBounceVertical = true
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }

    @objc
    private func refreshData() {
        presenter.getTrending()
    }

    private func configurePagination() {
        let nibName = String(describing: FooterRefreshControl.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        let kind = UICollectionView.elementKindSectionFooter
        collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: footerReuseIdentifier)
    }
}

extension GifsListViewController {


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

    func startLoadMore() {
        self.footerRefreshControl?.startAnimate()
    }

    func stopLoadMore() {
        self.footerRefreshControl?.stopAnimate()
    }
}

extension GifsListViewController {
    // Footer aniation logick

    //compute the scroll value and play witht the threshold to get desired effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold   = 100.0 ;
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        var triggerThreshold  = Float((diffHeight - frameHeight))/Float(threshold);
        triggerThreshold   =  min(triggerThreshold, 0.0)
        let pullRatio  = min(abs(triggerThreshold),1.0);
        self.footerRefreshControl?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(pullRatio))
        if pullRatio >= 1 {
            self.footerRefreshControl?.animateFinal()
        }
        print("pullRation:\(pullRatio)")
    }

    //compute the offset and call the load method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let diffHeight = contentHeight - contentOffset
        let frameHeight = scrollView.bounds.size.height
        let pullHeight  = abs(diffHeight - frameHeight)
        print("pullHeight:\(pullHeight)")
        if pullHeight == 0.0
        {
            if self.footerRefreshControl?.isAnimatingFinal ?? false {
                presenter.loadMore()
            }
        }
    }
}

extension GifsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO show details
        print("selected \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerRefreshControl?.prepareInitialAnimation()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerRefreshControl?.stopAnimate()
        }
    }
}

extension GifsListViewController: UICollectionViewDataSource {
    private var reuseIdentifier: String { "GifCellViewId" }

    private var footerReuseIdentifier: String { "FooterRefreshControl" }

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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerReuseIdentifier, for: indexPath)
            if let refresh = footerView as? FooterRefreshControl {
                self.footerRefreshControl = refresh
                self.footerRefreshControl?.backgroundColor = UIColor.clear
            }
            return footerView
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerReuseIdentifier, for: indexPath)
            return headerView
        }
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if isLoading {
//            return CGSize.zero
//        }
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }

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
