//
//  URBNSwiftAlertViewController.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import URBNConvenience

public enum URBNSwAlertType {
    case fullCustom, customView, customButton, fullStandard
}

open class URBNSwAlertViewController: UIViewController {
    var alertConfiguration = URBNSwAlertConfiguration()
    public var alertStyler = URBNSwAlertController.shared.alertStyler {
        didSet {
            alertConfiguration.styler = self.alertStyler
        }
    }
    var alertController = URBNSwAlertController.shared
    var alertView: URBNSwAlertView?
    
    // convenience
    fileprivate var blurImageView: UIImageView?
    
    // handlers
    var dismissingHandler: ((Bool) -> Void)?

    public convenience init(title: String? = nil, message: String? = nil) {
        self.init(type: .fullStandard, title: title, message: message)
    }
    
    public convenience init(customView: UIView) {
        self.init(type: .customView)
        
        alertConfiguration.customView = customView
    }
    
    public convenience init(title: String? = nil, message: String? = nil, customButtons: URBNSwAlertButtonContainer) {
        self.init(type: .customButton, title: title, message: message)
    }
    
    public convenience init(customView: UIView, customButtons: URBNSwAlertButtonContainer) {
        self.init(type: .fullCustom)
    }
    
    private init(type: URBNSwAlertType, title: String? = nil, message: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        alertConfiguration.type = type
        alertConfiguration.title = title ?? ""
        alertConfiguration.message = message ?? ""
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
        
        guard let ac = alertView else {
            assertionFailure("failed to unwrap an alertContainer")
            return
        }
        
        setUpBackground()
        layout(alertContainer: ac)
        
        setVisible(isVisible: true)
        
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
            alertContainer.widthAnchor.constraint(equalToConstant: alertStyler.alertWidth).isActive = true
            alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    private var scaler: CGFloat { return 0.3 }
    
    func setVisible(isVisible: Bool, completion: ((Void) -> Void)? = nil) {
        guard let ac = alertView else {
            assertionFailure()
            return
        }
        
        if isVisible {
            ac.alpha = 0.0
            ac.transform = CGAffineTransform(scaleX: scaler, y: scaler)
        }
        
        let alpha: CGFloat = isVisible ? 1.0 : 0.0
        let endingTransform = isVisible ? CGAffineTransform.identity : CGAffineTransform(scaleX: scaler, y: scaler)
        
        let bounceAnimation = {
            ac.transform = endingTransform
        }
        
        let fadeAnimation = { [unowned self] in
            ac.alpha = alpha
            if self.alertStyler.blurEnabled {
                self.blurImageView?.alpha = alpha
            }
        }
        
        if alertStyler.isAnimated {
            let duration = TimeInterval(alertStyler.animationDuration)
            let damping = alertStyler.animationDamping
            let initVel = isVisible ? 0 : alertStyler.animationInitialVelocity
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: initVel, options: [], animations: bounceAnimation, completion: { (complete) in
                if complete {
                    completion?()
                }
            })
            
            UIView.animate(withDuration: duration/2, animations: fadeAnimation)
        }
        else {
            fadeAnimation()
            bounceAnimation()
            completion?()
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

// MARK: Actions
extension URBNSwAlertViewController {
    public func show() {
       alertView = URBNSwAlertView(configuration: alertConfiguration)
        
        if !alertConfiguration.actions.isEmpty {
            // TODO fix this - the alert view cannot be adding its own buttons, that should be the alert view contorller's job alone
            alertView?.addActions(alertConfiguration.actions)

            for action in alertConfiguration.actions {
                if action.shouldDismiss {
                    action.button?.addTarget(self, action: #selector(dismissAlert(sender:)), for: .touchUpInside)
                }
            }
        }
        
        alertController.addAlertToQueue(avc: self)
    }
    
    func dismissAlert(sender: Any) {
        view.endEditing(true)
        
        // tell controller to remove top controller and show next alert
        alertController.popQueueAndShowNextIfNecessary()
        
        setVisible(isVisible: false) {  [unowned self] in
            self.dismiss(animated: false, completion: nil)
            self.dismissingHandler?(sender is UITapGestureRecognizer)
        }
    }
}

extension URBNSwAlertViewController {
    @available(*, unavailable, message: "use addActions instead")
    public func addAction(_ action: URBNSwAlertAction) {}
    
    public func addActions(_ actions: URBNSwAlertAction...) {
        addActions(actions)
    }
    
    public func addActions(_ actions: [URBNSwAlertAction]) {
        alertConfiguration.actions += actions
        alertConfiguration.isActiveAlert = !actions.filter{$0.type != .passive}.isEmpty
    }
}

