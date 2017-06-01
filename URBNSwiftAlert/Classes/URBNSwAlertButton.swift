//
//  URBNSwAlertButton.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/23/17.
//
//

import Foundation

// For custom button containers
public protocol URBNSwAlertButtonContainer: class {
    var containerView: UIView { get }
    var actions: [URBNSwAlertAction] { get }
}

public class URBNSwAlertButton: UIButton {
    let styler: URBNSwAlertStyler
    let action: URBNSwAlertAction
    
    init(styler: URBNSwAlertStyler, action: URBNSwAlertAction) {
        self.styler = styler
        self.action = action
        
        super.init(frame: CGRect.zero)
        
        setTitle(action.title, for: .normal)
        
        let titleColor = styler.buttonTitleColor(actionType: action.type, isEnabled: isEnabled)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = styler.buttonBackgroundColor(actionType: action.type, isEnabled: action.isEnabled)
    }
    
    public override var isHighlighted: Bool {
        didSet {
            switch action.type {
            case .destructive:
                backgroundColor = isHighlighted ? styler.destructiveButtonHighlightColor : styler.destructiveButtonBackgroundColor
            case .cancel:
                backgroundColor = isHighlighted ? styler.cancelButtonHighlightColor : styler.cancelButtonBackgroundColor
            case .custom, .normal, .passive:
                backgroundColor = isHighlighted ? styler.standardButtonHighlightColor : styler.standardButtonBackgroundColor
            }
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? styler.standardButtonSelectedBackgroundColor : styler.buttonBackgroundColor(actionType: action.type, isEnabled: isEnabled)
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            setTitleColor(styler.buttonTitleColor(actionType: action.type, isEnabled: isEnabled), for: .normal)
            backgroundColor = styler.buttonBackgroundColor(actionType: action.type, isEnabled: isEnabled)
            alpha = isEnabled ? 1.0 : styler.disabledButtonAlpha
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

