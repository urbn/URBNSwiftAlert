//
//  URBNSwAlertButton.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/23/17.
//
//

import Foundation

// For custom button containers
public protocol URBNSwAlertButtonContainer {
    var customButtons: [UIButton] { get }
    var containerView: UIView { get }
    var buttonStackView: UIStackView { get }
    var actions: [URBNSwAlertAction] { get }
    
    func addAction(_ action: URBNSwAlertAction)
    func addActions(_ actions: URBNSwAlertAction...)
    func addActions(_ actions: [URBNSwAlertAction])
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

