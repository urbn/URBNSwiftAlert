//
//  URBNSwiftAlertViewController.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import URBNConvenience

open class URBNSwAlertViewController: UIViewController {
    
    var alertConfiguration: URBNSwAlertConfiguration
    var alertController: URBNSwAlertController
    var alertStyler = URBNSwAlertStyler()
    var alertView: UIView?
    
    fileprivate var blurImageView: UIImageView?
    fileprivate var customView: UIView?
    
    /**
     *  Initialize with a title and/or message, as well as a customView if desired
     *
     *  @param title   Optional. The title text displayed in the alert
     *  @param message Optional. The message text displayed in the alert
     *  @param view    The custom UIView you wish to display in the alert
     *
     *  @return A URBNAlertViewController ready to be configurated further or displayed
     */
    
    public init(title: String, message: String? = nil, customView: UIView? = nil) {
        
        alertConfiguration = URBNSwAlertConfiguration()
        alertController = URBNSwAlertController()
        
        super.init(nibName: nil, bundle: nil)
        
        alertView = customView ?? URBNSwAlertView(config: alertConfiguration, styler: alertStyler)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        if alertStyler.blurEnabled {
            addBlurScreenshot()
        }
        else if let bgTintColor = alertStyler.backgroundTintColor {
            view.backgroundColor = bgTintColor
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension URBNSwAlertViewController {
    func addBlurScreenshot(withSize size: CGSize? = nil) {
        if let screenShot = UIImage.screenShot(view: viewForScreenshot, afterScreenUpdates: true) {
            let blurredSize = size ?? viewForScreenshot.bounds.size
            let blurredImage = screenShot.applyBlur(withRadius: alertStyler.blurRadius, tintColor: alertStyler.blurTintColor, saturationDeltaFactor: alertStyler.saturationDelta, maskImage: nil)
            
            
            let rect = CGRect(x: 0, y: 0, width: blurredSize.width, height: blurredSize.height)
            
            blurImageView = UIImageView(frame: rect)
            blurImageView?.image = blurredImage
            _ = blurImageView?.wrapInView(view)
        }
    }
    
    var viewForScreenshot: UIView {
        return alertConfiguration.presentationView ?? alertController.presentingWindow
    }
}

// MARK: Actions
extension URBNSwAlertViewController {
    public func show() {
        // TODO margin settings
        
        alertController.addAlertToQueue(avc: self)
    }
}
