//
//  skeletonLoader.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 22/10/24.
//

import UIKit

extension UIView {
    func showSkeletonLoader() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        self.layer.cornerRadius = 8
        let shimmerAnimation = CABasicAnimation(keyPath: "opacity")
        self.isUserInteractionEnabled = false
        shimmerAnimation.fromValue = 1
        shimmerAnimation.toValue = 0.5
        shimmerAnimation.duration = 0.8
        shimmerAnimation.autoreverses = true
        shimmerAnimation.repeatCount = .infinity
        self.layer.add(shimmerAnimation, forKey: "skeletonLoader")
    }
    
    func hideSkeletonLoader() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.layer.removeAnimation(forKey: "skeletonLoader")
    }
}

