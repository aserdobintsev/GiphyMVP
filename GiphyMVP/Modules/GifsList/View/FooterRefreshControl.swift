//
//  FooterRefreshControl.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/7/19.
//  Copyright © 2019 Alexander Serdobintsev.
//

import UIKit

class FooterRefreshControl: UICollectionReusableView {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet private weak var tryAgainButton: UIButton!

    var isAnimatingFinal: Bool = false
    var currentTransform: CGAffineTransform?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        activityIndicator.isHidden = false
        self.prepareInitialAnimation()
    }

    func setTransform(inTransform: CGAffineTransform, scaleFactor: CGFloat) {
        if isAnimatingFinal {
            return
        }
        self.currentTransform = inTransform
        self.activityIndicator.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
    }

    //reset the animation
    func prepareInitialAnimation() {
        self.isAnimatingFinal = false
        self.activityIndicator.stopAnimating()
        self.activityIndicator.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }

    func startAnimate() {
        self.isAnimatingFinal = true
        self.activityIndicator.startAnimating()
    }

    func stopAnimate() {
        self.isAnimatingFinal = false
        self.activityIndicator.stopAnimating()
    }

    //final animation to display loading
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
        UIView.animate(withDuration: 0.2) {
            self.activityIndicator.transform = CGAffineTransform.identity
        }
    }
}
