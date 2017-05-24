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
    var title = ""
    
    /**
     *  Message text for the alert
     */
    var message = ""
    
    /**
     *  Array of actions added to the alert
     */
    var actions = [URBNSwAlertAction]()
    
    /**
     *  Array of UITextFields added to the array
     */
    var textFieldInputs = [UITextField]()
    
    /**
     *  The view to present from when using showInView:
     */
    var presentationView: UIView?
    
    /**
     *  Flag if the alert is active. False = a passive alert
     */
    var isActiveAlert = false
    
    /**
     *  Duration of a passive alert (no buttons added)
     */
    var duration = 3.0
    
    /**
     *  When set to YES, you can touch outside of an alert to dismiss it
     */
    var touch = true
}
