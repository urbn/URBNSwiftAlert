//
//  URBNSwAlertStyler.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation
import URBNConvenience

public struct URBNSwAlertStyler {
    public var type: URBNSwAlertType = .fullStandard
    
    /**
     * Pass no to disable blurring in the background
     */
    public var blurEnabled = true
    
    /**
     * Background color of alert view
     */
    public var backgroundColor = UIColor.white
    
    /**
     * Tint color of the view behind the Alert. Blur must be disabled
     */
    public var backgroundTintColor: UIColor?
    /**
     * Opacity of the alert view's shadow
     */
    public var alertViewShadowOpacity: Float = 0.0
    
    /**
     * Radius of the blurred snapshot
     */
    public var blurRadius: CGFloat = 5.0
    
    /**
     * Radius of the alert view's shadow
     */
    public var alertViewShadowRadius: CGFloat = 0.0
    
    /**
     * Color of the alert view's shadow
     */
    public var alertViewShadowColor = UIColor.clear.cgColor
    
    /**
     * Offset of the alert view's shadow
     */
    public var alertShadowOffset = CGSize.zero
    
    /**
     * Tint color of the blurred snapshot
     */
    public var blurTintColor: UIColor = UIColor.white.withAlphaComponent(0.4) {
        didSet {
            assert(blurTintColor.cgColor.alpha < 1.0, "URBNAlertStyle: blurTintColor alpha component must be less than 1.0 to see the blur effect. Please use colorWithAlphaComponent: when setting a custom blurTintColor, for example: UIColor.white.withAlphaComponent(0.4)")
        }
    }
    
    /**
     * Saturation blur factor of the blurred snapshot. 1 is normal. < 1 removes color, > 1 adds color
     */
    public var saturationDelta: CGFloat = 1.0
    
    /**
     * Bool for using an animation to present alert view
     */
    public var isAnimated: Bool = true
    
    /**
     * Duration of the presenting and dismissing of the alert view
     */
    public var animationDuration: CGFloat = 0.6
    
    /**
     * Spring damping for the presenting and dismissing of the alert view
     */
    public var animationDamping: CGFloat = 0.6
    
    /**
     * Spring initial velocity for the presenting and dismissing of the alert view
     */
    public var animationInitialVelocity: CGFloat = -10.0
    
    /**
     * Width of the alert.  Used if no insets are given.  The alert view will use its most compressed layout values for height
     */
    public var alertWidth = UIScreen.main.bounds.width - 90
    
    /**
     * Insets of the alert from the top / left / bottom / right of the screen.
     */
    public var alertWrappingInsets: UIEdgeInsets?
    
    /**
     * Margin between sections in the alert. ie margin between the title and the message; message and the buttons, etc.
     */
    public var standardAlertLabelVerticalSpacing: CGFloat = 10.0
    
    /**
     * Insets of the whole standard alert view when not using custom views.
     */
    public var standardAlertViewInsets = UIEdgeInsets(top: 24, left: 16, bottom: 5, right: 16)
    
    /**
     * Text color of a disabled button
     */
    public var disabledButtonTitleColor = UIColor.lightGray
    /**
     * Background color of a disabled button for an active alert
     */
    public var disabledButtonBackgroundColor = UIColor.darkGray
    /**
     * Alpha value of a disabled button
     */
    public var disabledButtonAlpha: CGFloat = 1.0
    
    /**
     * Text color of cancel button title
     */
    public var cancelButtonTitleColor = UIColor.black
    /**
     * Background color of the cancel button for an active alert
     */
    public var cancelButtonBackgroundColor = UIColor.gray
    
    /**
     * Background color of a highlighted button for a cancel action
     */
    public var cancelButtonHighlightBackgroundColor = UIColor.darkGray
    
    /**
     * Text color of cancel button title when highlighted
     */
    public var cancelButtonHighlightTitleColor = UIColor.black
    
    /**
     * Height of the alert's buttons
     */
    public var standardButtonHeight: CGFloat = 44.0
    
    /**
     * Text color of the button titles
     */
    public var standardButtonTitleColor = UIColor.black
    
    /**
     * Background color of the buttons for active alerts
     */
    public var standardButtonBackgroundColor = UIColor.gray
    
    /**
     * Background color of a highlighted button for an active alert
     */
    public var standardButtonHighlightBackgroundColor = UIColor.darkGray
    
    /**
     * Background color of a selected button for an active alert
     */
    public var standardButtonSelectedBackgroundColor = UIColor.lightGray
    
    /**
     * Button title color for a selected state
     */
    public var standardButtonSelectedTitleColor = UIColor.black
    
    /**
     * Button container inset constraints
     */
    public var standardButtonContainerInsetConstraints = InsetConstraints(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), priority: UILayoutPriorityDefaultHigh)
    
    public var standardButtonSpacing: CGFloat = 10.0
    
    /**
     * Corner radius of the alert's buttons
     */
    public var standardButtonCornerRadius: CGFloat = 0.0
    
    /**
     * Font of the button's titles
     */
    public var standardButtonFont = UIFont.systemFont(ofSize: 12.0)
    
    /**
     * Button title color on highlight
     */
    public var standardButtonHighlightTitleColor = UIColor.black
    
    /**
     * Text color of destructive button colors
     */
    public var destructiveButtonTitleColor = UIColor.red
    
    /**
     * Text color of destructive button title when highlighted
     */
    public var destructiveButtonHighlightTitleColor = UIColor.red
    
    /**
     * Background color of the denial button for an active alert (at position 0)
     */
    public var destructiveButtonBackgroundColor = UIColor.gray
    
    /**
     * Background color of a highlighted button for a destructive action
     */
    public var destructiveButtonHighlightBackgroundColor = UIColor.darkGray
    
    /**
     * Font of the alert's title
     */
    public var titleFont = UIFont.systemFont(ofSize: 14)
    
    /**
     * Font of the alert's message
     */
    public var messageFont = UIFont.systemFont(ofSize: 12.0)
    
    /**
     * Text color of the alert's title
     */
    public var titleColor = UIColor.black
    
    /**
     * Text color of the alert's message
     */
    public var messageColor = UIColor.black
    
    /**
     * Alignment of the titles's message
     */
    public var titleAlignment = NSTextAlignment.center
    
    /**
     * Alignment of the alert's message
     */
    public var messageAlignment = NSTextAlignment.center
    
    /**
     * Max input length for the text field when enabled
     */
    public var textFieldMaxLength = Int.max
    
    /**
     * Text color of the error label text
     */
    public var textFieldErrorMessageColor = UIColor.red
    
    /**
     * Text font of the error label text
     */
    public var textFieldErrorMessageFont = UIFont.systemFont(ofSize: 12.0)
    
    /**
     *  Text Insets for input text fields on alerts
     */
    public var textFieldEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    /**
     * Corner radius of the alert view itself
     */
    public var alertCornerRadius: CGFloat = 0.0
    
    /**
     *  Vertical margin between textfields
     */
    public var textFieldVerticalMargin: CGFloat = 0.0
    
    /**
     *  Layout axis for buttons (for 3+ always vertical always used)
     */
    public var buttonsLayoutAxis = UILayoutConstraintAxis.horizontal
    
    /**
     *  Layout Margins for the alert title
     */
    public var titleLabelInsetConstraints = InsetConstraints(insets: UIEdgeInsets.zero, priority: UILayoutPriorityDefaultHigh)
    
    /**
     *  Layout Margins for the alert message
     */
    public var messageInsetConstraints = InsetConstraints(insets: UIEdgeInsets.zero, priority: UILayoutPriorityDefaultHigh)
    
    /**
     * UIEdgeInsets used at the external margins for the buttons of the alert's buttons
     */
    public var buttonInsetConstraints = InsetConstraints(insets: UIEdgeInsets.zero, priority: UILayoutPriorityDefaultHigh)
    
    /**
     * Width of the alert's button's border layer
     */
    public var buttonBorderWidth: CGFloat = 0.0
    
    /**
     * UIColor of the alert's button's border
     */
    public var buttonBorderColor = UIColor.clear.cgColor
    
    /**
     * Opacity of the alert's button's shadows
     */
    public var buttonShadowOpacity: Float = 0.0
    
    /**
     * Radius of the alert's button's shadows
     */
    public var buttonShadowRadius: CGFloat = 0.0
    
    /**
     * Color of the alert's button's shadows
     */
    public var buttonShadowColor = UIColor.clear.cgColor
    
    /**
     * Offset of the alert's button's shadows
     */
    public var buttonShadowOffset = CGSize.zero
    
    /**
     * The view you want to become the first responder when the alert view is finished presenting
     * The alert position will adjust for the keyboard when using this property
     */
    public var firstResponder: UIView?
}

// MARK: Standard Button Styling
extension URBNSwAlertStyler {
    /**
     *  Returns the correct title color for given an actionType
     *
     *  @param actionType Action type associated with the button
     *
     *  @return
     */
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
    
    /**
     *  Returns the correct background color for given an actionType
     *
     *  @param actionType Action type associated with the button
     *
     *  @return
     */
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

