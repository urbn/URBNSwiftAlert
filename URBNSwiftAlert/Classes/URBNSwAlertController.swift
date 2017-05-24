//
//  URBNSwiftAlertController.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation

struct URBNSwAlertController {
    
    var alertStyler: URBNSwAlertStyler?
    
    private var alertIsVisible = false
    private var queue: [URBNSwAlertViewController] = []
    private lazy var alertWindow = UIWindow(frame: UIScreen.main.bounds)
    var presentingWindow = UIApplication.shared.windows.first ?? UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: Queueing
    public mutating func addAlertToQueue(avc: URBNSwAlertViewController) {
        queue.append(avc)
        
        showNextAlert()
    }
    
    public mutating func showNextAlert() {
        guard let nextAVC = queue.first, !alertIsVisible else { return }
        
        // between here and there, pop
        
        if let presentationView = nextAVC.alertConfiguration.presentationView {
            var rect = nextAVC.view.frame
            rect.size.width = presentationView.frame.size.width
            rect.size.height = presentationView.frame.size.height
            nextAVC.view.frame = rect
            
            nextAVC.alertConfiguration.presentationView?.addSubview(nextAVC.view)
        }
        else {
            //        NotificationCenter.default.addObserver(self, selector: #selector(resignActive:) , name: "UIWindowDidBecomeKeyNotification", object: nil)
            setupAlertWindow()
            alertWindow.rootViewController = nextAVC
            alertWindow.makeKeyAndVisible()
        }
    }
    
    private mutating func setupAlertWindow() {
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.isHidden = false
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(resignActive), name: NSNotification.Name(rawValue: "UIWindowDidBecomeKeyNotification"), object: nil)
    }
}
