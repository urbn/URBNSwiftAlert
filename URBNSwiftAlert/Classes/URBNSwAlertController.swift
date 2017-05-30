//
//  URBNSwiftAlertController.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import Foundation

class URBNSwAlertController: NSObject {
    public static let shared = URBNSwAlertController()
    public var alertStyler = URBNSwAlertStyler()
    
    private var alertIsVisible = false
    private var queue: [URBNSwAlertViewController] = []
    private var alertWindow: UIWindow?
    public var presentingWindow = UIApplication.shared.windows.first ?? UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: Queueing
    public func addAlertToQueue(avc: URBNSwAlertViewController) {
        queue.append(avc)
        
        showNextAlert()
    }
    
    public func showNextAlert() {
        guard let nextAVC = queue.first, !alertIsVisible else { return }
        
        nextAVC.dismissingHandler = {[unowned self] wasTouchedOutside in
            if wasTouchedOutside {
                self.dismiss(alertViewController: nextAVC)
            }
            
            if self.queue.isEmpty {
                self.presentingWindow.makeKeyAndVisible()
                self.alertWindow?.isHidden = true
                self.alertWindow = nil
            }
        }
        
        if let presentationView = nextAVC.alertConfiguration.presentationView {
            var rect = nextAVC.view.frame
            rect.size.width = presentationView.frame.size.width
            rect.size.height = presentationView.frame.size.height
            nextAVC.view.frame = rect
            
            nextAVC.alertConfiguration.presentationView?.addSubview(nextAVC.view)
        }
        else {
            NotificationCenter.default.addObserver(self, selector: #selector(resignActive), name:  Notification.Name(rawValue: "UIWindowDidBecomeKeyNotification")  , object: nil)
            setupAlertWindow()
            alertWindow?.rootViewController = nextAVC
            alertWindow?.makeKeyAndVisible()
        }
    }
    
    private func setupAlertWindow() {
        if alertWindow == nil {
            alertWindow = UIWindow(frame: UIScreen.main.bounds)
        }
        alertWindow?.windowLevel = UIWindowLevelAlert
        alertWindow?.isHidden = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(resignActive) , name:  Notification.Name(rawValue: "UIWindowDidBecomeKeyNotification")  , object: nil)
    }
    
    func popQueueAndShowNextIfNecessary() {
        alertIsVisible = false
        if !queue.isEmpty {
            _ = queue.removeFirst()
        }
        showNextAlert()
    }
    
    func dismiss(alertViewController: URBNSwAlertViewController) {
        alertIsVisible = false
    }
    
    func resignActive() {}
}
