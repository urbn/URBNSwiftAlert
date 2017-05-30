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
    fileprivate lazy var titleLabel = UILabel()
    fileprivate lazy var messageView = UITextView()
    fileprivate let stackView = UIStackView()
    fileprivate lazy var standardButtons = [UIButton]()
    fileprivate lazy var buttonsSV = UIStackView()
    fileprivate lazy var buttonActions = [URBNSwAlertAction]()
    var configuration: URBNSwAlertConfiguration
    
    init(configuration: URBNSwAlertConfiguration) {
        self.configuration = configuration
        
        super.init(frame: CGRect.zero)
        
        backgroundColor = configuration.styler.backgroundColor
        
        stackView.axis = .vertical
        
        var insets: UIEdgeInsets
        var spacing: CGFloat
        
        switch configuration.type {
        case .fullStandard:
            addTitle()
            addMessage()
            addButtons()
            insets = configuration.styler.standardAlertViewInsets
            spacing = configuration.styler.standardAlertLabelVerticalSpacing
        case .customButton:
            addTitle()
            addMessage()
            addCustomButtons()
            insets = configuration.styler.standardAlertViewInsets
            spacing = configuration.styler.standardAlertLabelVerticalSpacing
        case .customView:
            addCustomView()
            addButtons()
            insets = UIEdgeInsets.zero
            spacing = 0.0
        case .fullCustom:
            addCustomView()
            addCustomButtons()
            insets = UIEdgeInsets.zero
            spacing = 0.0
        }
        
        stackView.spacing = spacing
        
        stackView.wrap(in: self, with: InsetConstraints(insets: insets, priority: UILayoutPriorityDefaultHigh))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension URBNSwAlertView {
    func addTitle() {
        if let title = configuration.title {
            titleLabel.font = configuration.styler.titleFont
            titleLabel.numberOfLines = 2
            titleLabel.text = title
            stackView.addArrangedSubview(titleLabel)
        }
    }
    
    func addMessage() {
        if let message = configuration.message, !message.isEmpty {
            messageView.isEditable = false
            messageView.text = message
            
            let buttonH = configuration.customButtons?.containerView.frame.height ?? configuration.styler.standardButtonHeight
            let maxTextViewH = UIScreen.main.bounds.height - titleLabel.intrinsicContentSize.height - 150.0 - (configuration.styler.alertWrappingInsets?.top ?? 16) * 2 - buttonH
            let maxWidth = UIScreen.main.bounds.width - (configuration.styler.standardAlertViewInsets.left + configuration.styler.standardAlertViewInsets.right)
            let messageSize = messageView.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
            let maxHeight = messageSize.height > maxTextViewH ? maxTextViewH : messageSize.height
            messageView.heightAnchor.constraint(equalToConstant: maxHeight).isActive = true
            
            stackView.addArrangedSubview(messageView)
        }
    }
    
    func addButtons() {
        buttonsSV.distribution = .fillEqually
        buttonsSV.spacing = configuration.styler.standardButtonSpacing
        let buttonInsets = InsetConstraints(insets: configuration.styler.standardButtonContainerInsets, priority: UILayoutPriorityDefaultHigh)
        stackView.addArrangedSubview(buttonsSV.wrapInNewView(with: buttonInsets))
    }
    
    func addCustomView() {
        if let customView = configuration.customView {
            stackView.addArrangedSubview(customView)
        }
    }
    
    func addCustomButtons() {
        if let customButtons = configuration.customButtons as? UIView {
            stackView.addArrangedSubview(customButtons)
        }
    }
}

extension URBNSwAlertView: URBNSwAlertButtonContainer {
    var containerView: UIView { return self }
    
    var actions: [URBNSwAlertAction] {
        return buttonActions
    }
    
    public func addActions(_ actions: [URBNSwAlertAction]) {
        for action in actions {
            let button = URBNSwAlertButton(styler: configuration.styler, action: action)
            buttonsSV.addArrangedSubview(button)
            action.add(button: button)
        }
    }
}

