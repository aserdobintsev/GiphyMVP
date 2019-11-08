//
//  GifViewCell.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation
import UIKit

class GifViewCell: UICollectionViewCell {

    @IBOutlet private weak var gifView: GifView!

    func configure(with gif: Gif, toggleAction: @escaping (Gif) -> Void) {
        let presenter = GifPresenter(view: gifView, gif: gif, toggleAction: toggleAction)
        gifView.configure(with: presenter)
    }
}