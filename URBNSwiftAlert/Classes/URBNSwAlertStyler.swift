//
//  URBNSwAlertStyler.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation

struct URBNSwAlertStyler {
    var blurEnabled = true
    var backgroundTintColor: UIColor?
    var blurRadius: CGFloat = 5.0
    var blurTintColor: UIColor = UIColor.white.withAlphaComponent(0.4) {
        didSet {
            assert(blurTintColor.cgColor.alpha < 1.0, "URBNAlertStyle: blurTintColor alpha component must be less than 1.0 to see the blur effect. Please use colorWithAlphaComponent: when setting a custom blurTintColor, for example: UIColor.white.withAlphaComponent(0.4)")
        }
    }
    
    var saturationDelta: CGFloat = 1.0
}
