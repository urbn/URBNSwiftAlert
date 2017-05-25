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
    
    init(alertable: URBNSwAlertable, title: String? = nil, message: String? = nil, customView: UIView? = nil, customButtons: URBNSwAlertButtonContainer? = nil) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = alertable.alertStyler.backgroundColor
        
        let stackView = UIStackView()
        
        if let title = title {
            titleLabel.text = title
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let message = message {
            messageView.isEditable = false
            messageView.text = message
        }
        
        stackView.wrap(in: self, with: InsetConstraints(insets: alertable.alertStyler.standardAlertViewInsets, priority: UILayoutPriorityDefaultHigh))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
