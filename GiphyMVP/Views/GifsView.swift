//
//  GifsView.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import Foundation

protocol GifsView: class {
    func startLoading()
    func stopLoading()
    func updateGifs()
}
