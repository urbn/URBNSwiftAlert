//
//  URBNSwAlertView.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation
import URBNConvenience

class URBNSwAlertView: UIView {
    private lazy var titleLabel = UILabel()
    private lazy var messageView = UITextView()
    fileprivate let stackView = UIStackView()
    fileprivate lazy var standardButtons = [UIButton]()
    fileprivate lazy var buttonsSV = UIStackView()
    fileprivate lazy var buttonsContainerView = UIView()
    fileprivate lazy var buttonActions = [URBNSwAlertAction]()
    fileprivate let alertable: URBNSwAlertable
    
    init(alertable: URBNSwAlertable, title: String? = nil, message: String? = nil, customView: UIView? = nil, customButtons: URBNSwAlertButtonContainer? = nil) {
        self.alertable = alertable
        
        super.init(frame: CGRect.zero)
        
        backgroundColor = alertable.alertStyler.backgroundColor
        
        stackView.spacing = alertable.alertStyler.standardAlertLabelVerticalSpacing
        stackView.axis = .vertical
        
        if let title = title {
            titleLabel.numberOfLines = 2
            titleLabel.text = title
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let message = message {
            messageView.isEditable = false
            messageView.text = message
            
            let buttonH = customButtons?.containerView.frame.height ?? alertable.alertStyler.standardButtonHeight
            let maxTextViewH = UIScreen.main.bounds.height - titleLabel.intrinsicContentSize.height - 150.0 - (alertable.alertStyler.alertWrappingInsets?.top ?? 16) * 2 - buttonH
            messageView.heightAnchor.constraint(equalToConstant: maxTextViewH).isActive = true
            stackView.addArrangedSubview(messageView)
        }
        
        if alertable.type != .customButton || alertable.type != .fullCustom {
            buttonsSV.spacing = alertable.alertStyler.standardButtonSpacing
            let buttonInsets = InsetConstraints(insets: alertable.alertStyler.standardButtonContainerInsets, priority: UILayoutPriorityDefaultHigh)
            buttonsSV.wrap(in: buttonsContainerView, with: buttonInsets)
            stackView.addArrangedSubview(buttonsContainerView)
        }
        
        stackView.wrap(in: self, with: InsetConstraints(insets: alertable.alertStyler.standardAlertViewInsets, priority: UILayoutPriorityDefaultHigh))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension URBNSwAlertView: URBNSwAlertButtonContainer {
    var customButtons: [UIButton] {
        return standardButtons
    }
    
    var buttonStackView: UIStackView {
        return buttonsSV
    }
    
    var containerView: UIView {
        return buttonsContainerView
    }
    
    var actions: [URBNSwAlertAction] {
        return buttonActions
    }
    
    public func addAction(_ action: URBNSwAlertAction) {}
    public func addActions(_ actions: URBNSwAlertAction...) {
        addActions(actions)
    }
    
    public func addActions(_ actions: [URBNSwAlertAction]) {
        for action in actions {
            let button = URBNSwAlertButton(styler: alertable.alertStyler, action: action)
            buttonsSV.addArrangedSubview(button)
            action.add(button: button)
        }
    }
}

