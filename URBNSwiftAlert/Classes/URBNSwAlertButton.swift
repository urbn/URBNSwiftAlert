//
//  AlertButton.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/23/17.
//
//

import Foundation

/**
 *  Conform a UIView to this protocol to generate a custom view that holds custom buttons
 */
public protocol AlertButtonContainer: class {
    var containerViewHeight: CGFloat { get }
    var actions: [AlertAction] { get }
}

public extension AlertButtonContainer where Self: UIView {
    var containerViewHeight: CGFloat {
        return height
    }
}

public class AlertButton: UIButton {
    let styler: AlertStyler
    let action: AlertAction
    
    init(styler: AlertStyler, action: AlertAction) {
        self.styler = styler
        self.action = action
        
        super.init(frame: CGRect.zero)
        
        setTitle(action.title, for: .normal)
        
        setTitleColor(styler.buttonTitleColor(actionType: action.type, isEnabled: isEnabled), for: .normal)
        setTitleColor(styler.buttonHighlightTitleColor(actionType: action.type, isEnabled: isEnabled), for: .highlighted)
        setTitleColor(styler.buttonSelectedTitleColor, for: .selected)
        backgroundColor = styler.buttonBackgroundColor(actionType: action.type, isEnabled: action.isEnabled)
        titleLabel?.font = styler.buttonFont
        layer.cornerRadius = styler.buttonCornerRadius
        layer.borderWidth = styler.buttonBorderWidth
        layer.borderColor = styler.buttonBorderColor.cgColor
        layer.shadowOpacity = styler.buttonShadowOpacity
        layer.shadowRadius = styler.buttonShadowRadius
        layer.shadowColor = styler.buttonShadowColor.cgColor
        layer.shadowOffset = styler.buttonShadowOffset
        contentEdgeInsets = styler.buttonContentInsets
    }
    
    public override var isHighlighted: Bool {
        didSet {
            switch action.type {
            case .destructive:
                backgroundColor = isHighlighted ? styler.destructiveButtonHighlightBackgroundColor : styler.destructiveButtonBackgroundColor
            case .cancel:
                backgroundColor = isHighlighted ? styler.cancelButtonHighlightBackgroundColor : styler.cancelButtonBackgroundColor
            case .custom, .normal, .passive:
                backgroundColor = isHighlighted ? styler.buttonHighlightBackgroundColor : styler.buttonBackgroundColor
            }
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? styler.buttonSelectedBackgroundColor : styler.buttonBackgroundColor(actionType: action.type, isEnabled: isEnabled)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            setTitleColor(styler.buttonTitleColor(actionType: action.type, isEnabled: isEnabled), for: .normal)
            setTitleColor(styler.buttonHighlightTitleColor(actionType: action.type, isEnabled: isEnabled), for: .highlighted)
            backgroundColor = styler.buttonBackgroundColor(actionType: action.type, isEnabled: isEnabled)
            alpha = isEnabled ? 1.0 : styler.disabledButtonAlpha
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

