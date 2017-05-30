//
//  URBNSwAlertConfiguration.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation

struct URBNSwAlertConfiguration {
    /**
     *  Title text for the alert
     */
    public var title: String?
    
    /**
     *  Message text for the alert
     */
    public var message: String?
    
    /**
     *  Array of UITextFields added to the array
     */
    public var textFieldInputs = [UITextField]()
    
    /**
     *  The view to present from when using showInView:
     */
    public var presentationView: UIView?
    
    /**
     *  Flag if the alert is active. False = a passive alert
     */
    public var isActiveAlert = false
    
    /**
     *  Duration of a passive alert (no buttons added)
     */
    public var duration = 3.0
    
    /**
     *  When set to YES, you can touch outside of an alert to dismiss it
     */
    public var touchOutsideToDismiss = true
    
    public var actions = [URBNSwAlertAction]()
    
    public var alertViewButtonContainer: URBNSwAlertButtonContainer?
    
    public var type = URBNSwAlertType.fullStandard
    
    public var styler = URBNSwAlertController.shared.alertStyler
    
    public var customView: UIView?
    
    public var customButtons: URBNSwAlertButtonContainer?
    
    public var customButtonHeight: CGFloat?
}
