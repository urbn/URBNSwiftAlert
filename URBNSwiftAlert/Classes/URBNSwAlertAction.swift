//
//  URBNSwAlertAction.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/23/17.
//
//

import Foundation

public enum URBNSwAlertActionType {
    case normal, destructive, cancel, passive, custom
}

public class URBNSwAlertAction: NSObject {
    let type: URBNSwAlertActionType
    let shouldDismiss: Bool
    let isEnabled: Bool
    let completion: ((URBNSwAlertAction) -> Void)?
    public var button: UIButton?
    var title: String?
    
    var isButton: Bool {
        return type != .passive
    }
    
    /**
     * Init an action with custom button, action type, dismissable and enabled bool, and completion handler
     * Used for creating connecting a custom button to an action
     * @param type  Required.  Type of action.
     * @param shouldDismiss Default true.  On completion, the action will dismiss the alert.
     * @param isEnabled Default true.  Action is enabled
     * @param completion Optional.  Closure that takes in the action as a param and completes when the selector of the target fires.
     */
    public convenience init(customButton: UIButton, shouldDismiss: Bool = true, isEnabled: Bool = true, completion: ((URBNSwAlertAction) -> Void)? = nil) {
        self.init(type: .custom, isEnabled: isEnabled, shouldDismiss: shouldDismiss, completion: completion)
        
        add(button: customButton)
    }

    /**
     * Init an action with a title, action type, dismissable and enabled bool, and completion handler
     * Used for creating a standard URBNSwiftAlert button or passive action
     * @param title Optional.  The button title
     * @param type  Required.  Type of action.
     * @param shouldDismiss Default true.  On completion, the action will dismiss the alert.
     * @param isEnabled Default true.  Action is enabled
     * @param completion Optional.  Closure that takes in the action as a param and completes when the selector of the target fires.
     */
    public convenience init(title: String? = nil, type: URBNSwAlertActionType, shouldDismiss: Bool = true, isEnabled: Bool = true, completion: ((URBNSwAlertAction) -> Void)? = nil) {
        self.init(type: type, isEnabled: isEnabled, shouldDismiss: shouldDismiss, completion: completion)
        
        self.title = title
    }
    
    private init(type: URBNSwAlertActionType, isEnabled: Bool, shouldDismiss: Bool, completion: ((URBNSwAlertAction) -> Void)?) {
        self.type = type
        self.shouldDismiss = shouldDismiss
        self.isEnabled = isEnabled
        self.completion = completion
        
        super.init()
    }
    
    func add(button: UIButton) {
        button.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        self.button = button
    }
    
    /**
     * Enables / Disables the Button in the alert (non custom only)
     */
    public func set(isEnabled: Bool) {
        button?.isEnabled = isEnabled
    }
    
    @objc func completeAction() {
        completion?(self)
    }
}
