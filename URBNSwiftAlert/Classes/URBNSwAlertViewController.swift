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
    
    fileprivate var blurImageView: UIImageView?
    fileprivate var customView: UIView?
    fileprivate var customButtonContainer: URBNSwAlertButtonContainer?
    
    /**
     *  Initialize with a title and/or message, as well as a customView if desired
     *
     *  @param title   Optional. The title text displayed in the alert
     *  @param message Optional. The message text displayed in the alert
     *  @param view    The custom UIView you wish to display in the alert
     *
     *  @return A URBNAlertViewController ready to be configurated further or displayed
     */
    
    public init(title: String? = nil, message: String? = nil, customView: UIView? = nil, customButtonContainer: URBNSwAlertButtonContainer? = nil) {
        
        alertConfiguration = URBNSwAlertConfiguration()
        alertController = URBNSwAlertController()
        self.customView = customView
        self.customButtonContainer = customButtonContainer
        
        super.init(nibName: nil, bundle: nil)
        
//        alertView = URBNSwAlertView(config: alertConfiguration, styler: alertStyler)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let av = alertView
        animate(in: av)
        
        // closure to dismiss
    }
    
    open func dismiss() {
     
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Layout and Animations
extension URBNSwAlertViewController {
    var alertView: UIView {
        if alertStyler.blurEnabled {
            addBlurScreenshot()
        }
        else if let bgTintColor = alertStyler.backgroundTintColor {
            view.backgroundColor = bgTintColor
        }
        
        let alertView = customView ?? URBNSwAlertView(config: alertConfiguration, styler: alertStyler)
        alertView.alpha = 0
        view.addSubviewsWithNoConstraints(alertView)
        alertView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return alertView
    }
    
    private var scaler: CGFloat { return 0.3 }
    
    func animate(in alertView: UIView) {
        alertView.transform = CGAffineTransform(scaleX: scaler, y: scaler)
        
        let duration = alertStyler.animationDuration
        let damping = alertStyler.animationDamping
        let initialV = alertStyler.animationInitialVelocity
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: initialV, options: [], animations: {
            alertView.transform = CGAffineTransform.identity
            alertView.alpha = 1.0
        }) { (complete) in
            
        }
    }
    
    func animate(out alertView: UIView) {
        
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
