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
    var button: UIButton?
    var title: String?
    
    var isButton: Bool {
        return type != .passive
    }
    
    public init(customButton: UIButton, shouldDismiss: Bool = true, isEnabled: Bool = true, completion: @escaping ((URBNSwAlertAction) -> Void)) {
        type = .custom
        self.shouldDismiss = shouldDismiss
        self.isEnabled = isEnabled
        self.completion = completion
    }

    public init(title: String, type: URBNSwAlertActionType, shouldDismiss: Bool = true, isEnabled: Bool = true, completion: @escaping ((URBNSwAlertAction) -> Void)) {
        self.type = type
        self.shouldDismiss = shouldDismiss
        self.isEnabled = isEnabled
        self.title = title
        self.completion = completion
    }
    
    func add(button: UIButton) {
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.button = button
    }
    
    @objc public func buttonPressed() {
        completion(self)
    }
}
