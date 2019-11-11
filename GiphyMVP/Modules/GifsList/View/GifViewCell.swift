//
//  GifViewCell.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import Foundation
import UIKit

class GifViewCell: UICollectionViewCell {

    @IBOutlet private weak var gifView: GifView!

    func configure(with gif: Gif) {
        let presenter = GifPresenter(view: gifView, gif: gif)
        gifView.configure(with: presenter)
    }
}
