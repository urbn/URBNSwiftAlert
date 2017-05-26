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
    var buttons: [UIButton: URBNSwAlertAction] { get }
    var containerView: UIView { get }
}

open class URBNSwAlertButton: UIButton {
    let styler: URBNSwAlertStyler
    let actionType: URBNSwAlertActionType
    
    init(styler: URBNSwAlertStyler, actionType: URBNSwAlertActionType) {
        self.styler = styler
        self.actionType = actionType
        
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
