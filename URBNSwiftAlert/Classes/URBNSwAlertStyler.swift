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
    
    public var disabledButtonTitleColor = UIColor.lightGray
    public var disabledButtonBackgroundColor = UIColor.darkGray
    public var disabledButtonAlpha: CGFloat = 1.0
    
    public var cancelButtonTitleColor = UIColor.black
    public var cancelButtonBackgroundColor = UIColor.gray
    public var cancelButtonHighlightColor = UIColor.darkGray
    
    public var standardButtonHeight: CGFloat = 44.0
    public var standardButtonTitleColor = UIColor.black
    public var standardButtonBackgroundColor = UIColor.gray
    public var standardButtonHighlightColor = UIColor.darkGray
    public var standardButtonSelectedBackgroundColor = UIColor.lightGray
    public var standardButtonContainerInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public var standardButtonSpacing: CGFloat = 10.0
    
    public var destructiveButtonTitleColor = UIColor.red
    public var destructiveButtonBackgroundColor = UIColor.gray
    public var destructiveButtonHighlightColor = UIColor.darkGray
    
    public var titleFont = UIFont.systemFont(ofSize: 14)
    public var messageFont = UIFont.systemFont(ofSize: 12.0)
    public var titleColor = UIColor.black
    public var messageColor = UIColor.black
    
    public var textFieldMaxLength = Int.max
    public var textFieldErrorMessageColor = UIColor.red
    public var textFieldEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
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
