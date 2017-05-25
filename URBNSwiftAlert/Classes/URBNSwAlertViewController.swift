//
//  URBNSwiftAlertViewController.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import URBNConvenience

protocol URBNSwAlertable {
    var alertConfiguration: URBNSwAlertConfiguration { get }
    var alertController: URBNSwAlertController { get }
    var alertStyler: URBNSwAlertStyler { get }
    var type: URBNSwAlertType { get set }
}

extension URBNSwAlertable {
    var alertConfiguration: URBNSwAlertConfiguration {
        return URBNSwAlertConfiguration()
    }
    
    var alertController: URBNSwAlertController {
        return URBNSwAlertController.shared
    }
    
    var alertStyler: URBNSwAlertStyler {
        return URBNSwAlertController.shared.alertStyler
    }
    
    var type: URBNSwAlertType {
        return .fullStandard
    }
}

enum URBNSwAlertType {
    case fullCustom, customView, customButton, standardTitle, standardMessage, fullStandard
}

open class URBNSwAlertViewController: UIViewController, URBNSwAlertable {
    // alertables
    let avAlertConfiguration: URBNSwAlertConfiguration
    let alertStyler = URBNSwAlertController.shared.alertStyler
    var alertController = URBNSwAlertController.shared
    
    // convenience
    fileprivate var blurImageView: UIImageView?
    var alertContainer: UIView?
    
    // handlers
    var dismissingHandler: ((Bool) -> Void)?
        
    public convenience init(title: String) {
        self.init(type: .standardTitle)
        
        alertContainer = URBNSwAlertView(alertable: self, title: title)
    }
    
    public convenience init(message: String) {
        self.init(type: .standardMessage)
    }

    public convenience init(title: String, message: String) {
        self.init(type: .fullStandard)
    }
    
    public convenience init(customView: UIView) {
        self.init(type: .customView)
    }
    
    public convenience init(title: String? = nil, message: String? = nil, customButtons: URBNSwAlertButtonContainer) {
        self.init(type: .customButton)
    }
    
    public convenience init(title: String? = nil, message: String? = nil, customView: UIView, customButtons: URBNSwAlertButtonContainer) {
        self.init(type: .fullCustom)
    }
    
    private init(type: URBNSwAlertType) {
        self.type = type
        avAlertConfiguration = URBNSwAlertConfiguration()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: URNBSwAlertable Conformance
    var type: URBNSwAlertType
    var alertConfiguration: URBNSwAlertConfiguration {
        return avAlertConfiguration
    }
    
    /**
     *  Initialize with a
     *
     *  @param title   Optional. The title text displayed in the alert
     *  @param message Optional. The message text displayed in the alert
     *  @param view    The custom UIView you wish to display in the alert
     *
     *  @return A URBNAlertViewController ready to be configurated further or displayed
     */
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let ac = alertContainer else {
            assertionFailure("failed to unwrap an alertContainer")
            return
        }
        
        setUpBackground()
        layout(alertContainer: ac)
        
        animate(in: ac)
        
        if alertConfiguration.touchOutsideToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAlert(sender:)))
            view.addGestureRecognizer(tap)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Layout and Animations
extension URBNSwAlertViewController {
    func setUpBackground() {
        if alertStyler.blurEnabled {
            addBlurScreenshot()
        }
        else if let bgTintColor = alertStyler.backgroundTintColor {
            view.backgroundColor = bgTintColor
        }
    }
    
    func layout(alertContainer: UIView) {
        alertContainer.alpha = 0.0
        
        let container = alertConfiguration.presentationView ?? view
        
        if let insets = alertStyler.alertWrappingInsets {
            _ = alertContainer.wrapInView(container, withInsets: insets)
        }
        else {
            container?.addSubviewsWithNoConstraints(alertContainer)
            alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    private var scaler: CGFloat { return 0.3 }
    
    func animate(in alertView: UIView) {
        alertView.transform = CGAffineTransform(scaleX: scaler, y: scaler)
        
        UIView.animate(withDuration: TimeInterval(alertStyler.animationDuration),
                       delay: 0.0,
                       usingSpringWithDamping: alertStyler.animationDamping,
                       initialSpringVelocity: alertStyler.animationInitialVelocity,
                       options: [],
                       animations: {
            alertView.transform = CGAffineTransform.identity
            alertView.alpha = 1.0
        }) { (complete) in
            
        }
    }
    
    func animate(out alertView: UIView, completion: @escaping (Void) -> Void) {
        UIView.animate(withDuration: TimeInterval(alertStyler.animationDuration/2.0),
                       delay: 0,
                       usingSpringWithDamping: alertStyler.animationDamping,
                       initialSpringVelocity: alertStyler.animationInitialVelocity,
                       options: [],
                       animations: { [unowned self] in
            alertView.transform = CGAffineTransform(scaleX: self.scaler, y: self.scaler)
            alertView.alpha = 0.0
        }) { (complete) in
            completion()
        }
    }
    
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

extension URBNSwAlertViewController {
    func dismissAlert(sender: Any) {
        view.endEditing(true)
        
        // tell controller to remove top controller and show next alert
        alertController.popQueueAndShowNextIfNecessary()
        
        guard let ac = alertContainer else {
            assertionFailure("failed to unwrap an alertContainer")
            return
        }
        
        animate(out: ac) { [unowned self] in
            self.dismiss(animated: false, completion: nil)
            self.dismissingHandler?(sender is UITapGestureRecognizer)
        }
    }
}

// MARK: Actions
extension URBNSwAlertViewController {
    public func show() {
        // TODO margin settings
        
        alertController.addAlertToQueue(avc: self)
    }
}
