//
//  GifView.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//  Copyright © 2019 Alexander Serdobintsev. All rights reserved.
//

import UIKit

class GifView: UIView {
    private let titleLabel = UILabel()
    private let gifImageView = UIImageView()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])

        gifImageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(gifImageView)
        NSLayoutConstraint.activate([
            gifImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            gifImageView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            gifImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gifImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            gifImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor)
        ])
    }

    func configure(with gif: Gif) {
        titleLabel.text = gif.title
        DispatchQueue.global(qos: .default).async { [weak self] in
            // TODO: add gif placeholder
            guard let url = URL(string: gif.stillUrl) else {
                return
            }
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.gifImageView.image = image
            }
        }
    }

}
