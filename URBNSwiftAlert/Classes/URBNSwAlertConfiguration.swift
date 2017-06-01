//
//  URBNSwAlertConfiguration.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation

public struct URBNSwAlertConfiguration {
    /**
     *  Title text for the alert
     */
    public var title: String?
    
    /**
     *  Message text for the alert
     */
    public var message: String?
    
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
    public var duration: CGFloat?
    
    /**
     *  When set to true, you can touch outside of an alert to dismiss it
     */
    public var touchOutsideToDismiss = false
    
    /**
     *  When set to true, you can touch outside of an alert to dismiss it
     */
    public var alertViewButtonContainer: URBNSwAlertButtonContainer?
    
    // Internal Variables
    var type = URBNSwAlertType.fullStandard
    var styler = URBNSwAlertController.shared.alertStyler
    var textFields = [UITextField]()
    var customView: UIView?
    var customButtons: URBNSwAlertButtonContainer?
    var actions = [URBNSwAlertAction]()
    var textFieldInputs = [UITextField]()
}
