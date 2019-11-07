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
    private let favouriteButton = UIButton(type: .roundedRect)

    var presenter: GifViewPresenter?

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        addTitle()
        addImage()
        addButton()
    }

    private func addTitle() {
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }

    private func addImage() {
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gifImageView)
        NSLayoutConstraint.activate([
            gifImageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            gifImageView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            gifImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gifImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10)
        ])
    }

    private func addButton() {
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(favouriteButton)
        NSLayoutConstraint.activate([
            favouriteButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor),
            favouriteButton.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            favouriteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            gifImageView.bottomAnchor.constraint(lessThanOrEqualTo: favouriteButton.topAnchor),
            favouriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        favouriteButton.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
    }

    @objc
    private func toggleFavourite() {
        self.presenter?.toggleFavourite()
    }

    func configure(with presenter: GifViewPresenter) {
        self.presenter = presenter
        presenter.load()
    }
}

extension GifView: GifViewProtocol {
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func setImageData(_ imageData: Data) {
        guard let image = UIImage(data: imageData) else {
            return
        }
        gifImageView.image = image
    }

    func setFavouritTitle(_ favouriteTitle: String) {
        favouriteButton.setTitle(favouriteTitle, for: .normal)
    }
}
