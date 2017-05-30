//
//  URBNSwAlertStyler.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation

public struct URBNSwAlertStyler {
    public var type: URBNSwAlertType = .fullStandard
    public var blurEnabled = true
    public var backgroundColor = UIColor.white
    public var backgroundTintColor: UIColor?
    public var blurRadius: CGFloat = 5.0
    public var blurTintColor: UIColor = UIColor.white.withAlphaComponent(0.4) {
        didSet {
            assert(blurTintColor.cgColor.alpha < 1.0, "URBNAlertStyle: blurTintColor alpha component must be less than 1.0 to see the blur effect. Please use colorWithAlphaComponent: when setting a custom blurTintColor, for example: UIColor.white.withAlphaComponent(0.4)")
        }
    }
    
    public var saturationDelta: CGFloat = 1.0
    public var isAnimated: Bool = true
    public var animationDuration: CGFloat = 0.6
    public var animationDamping: CGFloat = 0.6
    public var animationInitialVelocity: CGFloat = -10.0
    public var alertWidth = UIScreen.main.bounds.width - 90
    public var alertWrappingInsets: UIEdgeInsets?
    public var standardAlertLabelVerticalSpacing: CGFloat = 10.0
    public var standardAlertViewInsets = UIEdgeInsets(top: 24, left: 16, bottom: 5, right: 16)
    public var standardButtonHeight: CGFloat = 44.0
    public var disabledButtonTitleColor = UIColor.gray
    public var disabledButtonBackgroundColor = UIColor.lightGray
    public var disabledButtonAlpha: CGFloat = 1.0
    public var cancelButtonTitleColor = UIColor.black
    public var cancelButtonBackgroundColor = UIColor.white
    public var cancelButtonHighlightColor = UIColor.darkGray
    public var standardButtonTitleColor = UIColor.black
    public var standardButtonBackgroundColor = UIColor.blue
    public var standardButtonHighlightColor = UIColor.darkGray
    public var standardButtonSelectedBackgroundColor = UIColor.lightGray
    public var destructiveButtonTitleColor = UIColor.red
    public var destructiveButtonBackgroundColor = UIColor.white
    public var destructiveButtonHighlightColor = UIColor.darkGray
    public var standardButtonContainerInsets = UIEdgeInsets.zero
    public var standardButtonSpacing: CGFloat = 10.0
    public var titleFont = UIFont.systemFont(ofSize: 14)
    
//    public init() {}
}

// MARK: Standard Button Styling
extension URBNSwAlertStyler {
    public func buttonTitleColor(actionType: URBNSwAlertActionType, isEnabled: Bool) -> UIColor {
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
    
    public func buttonBackgroundColor(actionType: URBNSwAlertActionType, isEnabled: Bool) -> UIColor {
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
