//
//  URBNSwAlertAction.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/23/17.
//
//

import Foundation

enum URBNSwAlertActionType {
    case normal, destructive, cancel, passive, custom
}

public struct URBNSwAlertAction {
    let type: URBNSwAlertActionType
    let shouldDismiss: Bool
    var actionButton: URBNSwAlertButton?
    
    var isButton: Bool {
        return type != .passive
    }
    
    init(customButton: UIButton, shouldDismiss: Bool = true, completion: ((URBNSwAlertAction) -> Void)) {
        type = .custom
        self.shouldDismiss = shouldDismiss
    }

    init(title: String, type: URBNSwAlertActionType, shouldDismiss: Bool = true, completion: ((URBNSwAlertAction) -> Void)) {
        self.type = type
        self.shouldDismiss = shouldDismiss
    }
    
    func set(enabled: Bool) {
        if isButton, let button = actionButton {
            button.isEnabled = true
            style(button: button, isEnabled: true)
        }
    }
    
    private func style(button: URBNSwAlertButton, isEnabled: Bool) {
        let titleColor = button.styler.buttonTitleColor(actionType: button.actionType, isEnabled: isEnabled)
        
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = button.styler.buttonBackgroundColor(actionType: button.actionType, isEnabled: isEnabled)
        button.alpha = isEnabled ? 1.0 : button.styler.disabledButtonAlpha
    }
}
