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
    fileprivate lazy var textFieldErrorLabel = UILabel()
    fileprivate let stackView = UIStackView()
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
            addStandardComponents()
            addButtons()
            insets = configuration.styler.standardAlertViewInsets
            spacing = configuration.styler.standardAlertLabelVerticalSpacing
        case .customButton:
            addStandardComponents()
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

// MARK: Setup and add UI
extension URBNSwAlertView {
    func addStandardComponents() {
        if let title = configuration.title {
            titleLabel.font = configuration.styler.titleFont
            titleLabel.numberOfLines = 2
            titleLabel.textColor = configuration.styler.titleColor
            titleLabel.text = title
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let message = configuration.message, !message.isEmpty {
            messageView.font = configuration.styler.messageFont
            messageView.textColor = configuration.styler.messageColor
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
        
        if !configuration.textFields.isEmpty {
            for tf in configuration.textFields {
                tf.delegate = self
                stackView.addArrangedSubview(tf)
            }
            
            textFieldErrorLabel.numberOfLines = 0
            textFieldErrorLabel.lineBreakMode = .byWordWrapping
            textFieldErrorLabel.textColor = configuration.styler.textFieldErrorMessageColor
            stackView.addArrangedSubview(textFieldErrorLabel)
            textFieldErrorLabel.isHidden = true
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
    
    public func show(errorMessage: String) {
        textFieldErrorLabel.isHidden = false
        textFieldErrorLabel.text = errorMessage
    }
    
    public func addActions(_ actions: [URBNSwAlertAction]) {
        for action in actions {
            if action.type != .passive {
                let button = URBNSwAlertButton(styler: configuration.styler, action: action)
                buttonsSV.addArrangedSubview(button)
                action.add(button: button)
            }
        }
    }
}

extension URBNSwAlertView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charCount = textField.text?.characters.count ?? 0
        if let charCount = textField.text?.characters.count, range.length + range.location > charCount {
            return false
        }
        
        let newLength = charCount + string.characters.count - range.length
        
        return newLength < configuration.styler.textFieldMaxLength
    }
}
