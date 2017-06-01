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
    let completion: ((URBNSwAlertAction) -> Void)
    public var button: UIButton?
    var title: String?
    
    var isButton: Bool {
        return type != .passive
    }
    
    public init(customButton: UIButton, shouldDismiss: Bool = true, isEnabled: Bool = true, completion: @escaping ((URBNSwAlertAction) -> Void)) {
        type = .custom
        self.shouldDismiss = shouldDismiss
        self.isEnabled = isEnabled
        self.completion = completion
        
        super.init()
        
        add(button: customButton)
    }

    public init(title: String? = nil, type: URBNSwAlertActionType, shouldDismiss: Bool = true, isEnabled: Bool = true, completion: @escaping ((URBNSwAlertAction) -> Void)) {
        self.type = type
        self.shouldDismiss = shouldDismiss
        self.isEnabled = isEnabled
        self.title = title
        self.completion = completion
    }
    
    func add(button: UIButton) {
        button.addTarget(self, action: #selector(completeAction), for: .touchUpInside)
        self.button = button
    }
    
    public func set(isEnabled: Bool) {
        button?.isEnabled = isEnabled
    }
    
    @objc public func completeAction() {
        completion(self)
    }
}
