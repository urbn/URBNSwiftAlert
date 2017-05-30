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
    var alertStyler: URBNSwAlertStyler
    
    init(configuration: URBNSwAlertConfiguration) {
        self.alertStyler = configuration.styler
        
        super.init(frame: CGRect.zero)
        
        backgroundColor = alertStyler.backgroundColor
        
        stackView.spacing = alertStyler.standardAlertLabelVerticalSpacing
        stackView.axis = .vertical
        
        if let title = configuration.title {
            titleLabel.font = alertStyler.titleFont
            titleLabel.numberOfLines = 2
            titleLabel.text = title
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let message = configuration.message, !message.isEmpty {
            messageView.isEditable = false
            messageView.text = message
            
            let buttonH = configuration.customButtons?.containerView.frame.height ?? alertStyler.standardButtonHeight
            let maxTextViewH = UIScreen.main.bounds.height - titleLabel.intrinsicContentSize.height - 150.0 - (alertStyler.alertWrappingInsets?.top ?? 16) * 2 - buttonH
            let maxWidth = UIScreen.main.bounds.width - (alertStyler.standardAlertViewInsets.left + alertStyler.standardAlertViewInsets.right)
            let messageSize = messageView.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            let maxHeight = messageSize.height > maxTextViewH ? maxTextViewH : messageSize.height
            messageView.heightAnchor.constraint(equalToConstant: maxHeight).isActive = true
            
            stackView.addArrangedSubview(messageView)
        }
        
        if alertStyler.type != .customButton || alertStyler.type != .fullCustom {
            buttonsSV.distribution = .fillEqually
            buttonsSV.spacing = alertStyler.standardButtonSpacing
            let buttonInsets = InsetConstraints(insets: alertStyler.standardButtonContainerInsets, priority: UILayoutPriorityDefaultHigh)
            buttonsSV.wrap(in: buttonsContainerView, with: buttonInsets)
            stackView.addArrangedSubview(buttonsContainerView)
        }
        
        if let customView = configuration.customView {
            stackView.addArrangedSubview(customView)
        }
        
        stackView.wrap(in: self, with: InsetConstraints(insets: alertStyler.standardAlertViewInsets, priority: UILayoutPriorityDefaultHigh))
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
            let button = URBNSwAlertButton(styler: alertStyler, action: action)
            buttonsSV.addArrangedSubview(button)
            action.add(button: button)
        }
    }
}

