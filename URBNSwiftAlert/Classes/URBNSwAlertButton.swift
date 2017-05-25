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
}

enum URBNSwAlertActionType {
    case normal, destructive, cancel, passive
}

open class URBNSwAlertButton: UIButton {
    
}
