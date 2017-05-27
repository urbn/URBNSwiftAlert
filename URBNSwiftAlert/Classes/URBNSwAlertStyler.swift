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
    var backgroundColor = UIColor.white
    var backgroundTintColor: UIColor?
    var blurRadius: CGFloat = 5.0
    var blurTintColor: UIColor = UIColor.white.withAlphaComponent(0.4) {
        didSet {
            assert(blurTintColor.cgColor.alpha < 1.0, "URBNAlertStyle: blurTintColor alpha component must be less than 1.0 to see the blur effect. Please use colorWithAlphaComponent: when setting a custom blurTintColor, for example: UIColor.white.withAlphaComponent(0.4)")
        }
    }
    
    var saturationDelta: CGFloat = 1.0
    var isAnimated: Bool = true
    var animationDuration: CGFloat = 0.6
    var animationDamping: CGFloat = 0.6
    var animationInitialVelocity: CGFloat = -10.0
    var alertWidth = UIScreen.main.bounds.width - 90
    var alertWrappingInsets: UIEdgeInsets?
    var standardAlertLabelVerticalSpacing: CGFloat = 10.0
    var standardAlertViewInsets = UIEdgeInsets(top: 24, left: 16, bottom: 5, right: 16)
    var standardButtonHeight: CGFloat = 44.0
    var disabledButtonTitleColor = UIColor.gray
    var disabledButtonBackgroundColor = UIColor.lightGray
    var disabledButtonAlpha: CGFloat = 1.0
    var cancelButtonTitleColor = UIColor.black
    var cancelButtonBackgroundColor = UIColor.white
    var cancelButtonHighlightColor = UIColor.darkGray
    var standardButtonTitleColor = UIColor.black
    var standardButtonBackgroundColor = UIColor.blue
    var standardButtonHighlightColor = UIColor.darkGray
    var standardButtonSelectedBackgroundColor = UIColor.lightGray
    var destructiveButtonTitleColor = UIColor.red
    var destructiveButtonBackgroundColor = UIColor.white
    var destructiveButtonHighlightColor = UIColor.darkGray
    var standardButtonContainerInsets = UIEdgeInsets.zero
    var standardButtonSpacing: CGFloat = 10.0
}

// MARK: Standard Button Styling
extension URBNSwAlertStyler {
    func buttonTitleColor(actionType: URBNSwAlertActionType, isEnabled: Bool) -> UIColor {
        if !isEnabled {
            return disabledButtonTitleColor
        }
        
        switch actionType {
        case .cancel:
            return cancelButtonTitleColor
        case .destructive:
            return destructiveButtonTitleColor
        case .normal, .custom, .passive:
            return standardButtonTitleColor
        }
    }
    
    func buttonBackgroundColor(actionType: URBNSwAlertActionType, isEnabled: Bool) -> UIColor {
        if !isEnabled {
            return disabledButtonBackgroundColor
        }
        
        switch actionType {
        case .cancel:
            return cancelButtonBackgroundColor
        case .destructive:
            return destructiveButtonBackgroundColor
        case .normal, .custom, .passive:
            return standardButtonBackgroundColor
        }
    }
}
