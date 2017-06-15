//
//  URBNSwiftAlertViewController.swift
//  Pods
//
//  Created by Kevin Taniguchi on 5/22/17.
//
//

import URBNConvenience

open class URBNSwAlertViewController: UIViewController {
    public var alertConfiguration = URBNSwAlertConfiguration()
    public var alertStyler = URBNSwAlertController.shared.alertStyler {
        didSet {
            alertConfiguration.styler = self.alertStyler
        }
    }
    
    /**
     *  Initialize with a title and / or message
     *
     *  @param title   Optional. The title text displayed in the alert
     *  @param message Optional. The message text displayed in the alert
     *
     *
     *  @return A URBNSwiftAlertViewController ready to be configurated further or displayed
     */

    public convenience init(title: String? = nil, message: String? = nil) {
        self.init(type: .fullStandard, title: title, message: message)
    }
    
    /**
     *  Initialize with a custom view
     *
     *  @param customView Required.  A UIView or UIView subclass.  Any actions added will generate standard URBNSwAlert Buttons
     *
     *  @return A URBNSwiftAlertViewController with a custom view ready to be configurated further or displayed
     */
    
    public convenience init(customView: UIView) {
        self.init(type: .customView, customView: customView)
    }
    
    /**
     *  Initialize with a title / message / and a URBNSwAlertButtonContainer
     *
     *  @param customButtons Required.  A UIView that conforms to the URBNSwAlertButtonContainer protocol
     *  @param title   Optional. The title text displayed in the alert
     *  @param message Optional. The message text displayed in the alert
     *
     *  @return A URBNSwiftAlertViewController with custom buttons ready to be configurated further or displayed
     */
    
    public convenience init(title: String? = nil, message: String? = nil, customButtons: URBNSwAlertButtonContainer) {
        self.init(type: .customButton, title: title, message: message, customButtons: customButtons)
    }
    
    /**
     *  Initialize with a custom UIView and a URBNSwAlertButtonContainer
     *
     *  @param customButtons Required.  A UIView that conforms to the URBNSwAlertButtonContainer protocol
     *  @param customView  Required. A custom UIView
     *
     *  @return A URBNSwiftAlertViewController with a custom view and custom buttons ready to be configurated further or displayed
     */
    
    public convenience init(customView: UIView, customButtons: URBNSwAlertButtonContainer) {
        self.init(type: .fullCustom, customView: customView, customButtons: customButtons)
    }
    
    private init(type: URBNSwAlertType, title: String? = nil, message: String? = nil, customView: UIView? = nil, customButtons: URBNSwAlertButtonContainer? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        alertConfiguration.type = type
        alertConfiguration.title = title
        alertConfiguration.message = message
        alertConfiguration.customView = customView
        alertConfiguration.customButtons = customButtons
        
        if let customActions = customButtons?.actions {
            alertConfiguration.actions = customActions
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let ac = alertView else {
            assertionFailure("failed to unwrap an alertContainer")
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notif:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notif:)), name: .UIKeyboardWillHide, object: nil)
        
        setUpBackground()
        layout(alertContainer: ac)
        
        setVisible(isVisible: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.alertConfiguration.textFields.first?.becomeFirstResponder()
        }
        
        if alertConfiguration.touchOutsideToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAlert(sender:)))
            view.addGestureRecognizer(tap)
        }
    }
    
    var dismissingHandler: ((Bool) -> Void)?
    fileprivate var alertView: URBNSwAlertView?
    fileprivate var blurImageView: UIImageView?
    fileprivate var alertController = URBNSwAlertController.shared
    fileprivate var alertViewYContraint: NSLayoutConstraint?
    
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
        
        view.addSubviewsWithNoConstraints(alertContainer)
        if alertConfiguration.type != .customView && alertConfiguration.type != .fullCustom {
            alertContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - alertStyler.horizontalMargin*2).isActive = true
        }
        alertContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertViewYContraint = alertContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        alertViewYContraint?.isActive = true
    }
    
    func setVisible(isVisible: Bool, completion: ((Void) -> Void)? = nil) {
        let scaler: CGFloat = 0.3
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

// MARK: Show and Dismiss
extension URBNSwAlertViewController {
    public func show() {
       alertView = URBNSwAlertView(configuration: alertConfiguration)
        
        if !alertConfiguration.actions.isEmpty {
            switch alertConfiguration.type {
            case .fullStandard, .customView:
                alertView?.addActions(alertConfiguration.actions)
            case .customButton, .fullCustom:
                break
            }

            for action in alertConfiguration.actions {
                if action.shouldDismiss {
                    action.button?.addTarget(self, action: #selector(dismissAlert(sender:)), for: .touchUpInside)
                }
            }
            
            if !alertConfiguration.isActiveAlert || alertConfiguration.tapInsideToDismiss {
                let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAlert(sender:)))
                alertView?.addGestureRecognizer(tap)
            }
        }
        
        alertController.addAlertToQueue(avc: self)
    }
    
    public func show(inView view: UIView) {
        alertConfiguration.presentationView = view
        show()
    }
    
    public func dismissAlert(sender: Any) {
        view.endEditing(true)
        
        if !alertConfiguration.isActiveAlert && alertConfiguration.type != .customButton && alertConfiguration.type != .fullCustom {
            for action in alertConfiguration.actions {
                action.completeAction()
            }
        }
        
        // tell controller to remove top controller and show next alert
        alertController.popQueueAndShowNextIfNecessary()
        
        setVisible(isVisible: false) {  [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: false, completion: nil)
            strongSelf.dismissingHandler?(sender is UITapGestureRecognizer)
        }
    }
}

// MARK: Actions and Textfields
extension URBNSwAlertViewController {
    @available(*, unavailable, message: "use addActions instead")
    public func addAction(_ action: URBNSwAlertAction) {}
    
    public func addActions(_ actions: URBNSwAlertAction...) {
        addActions(actions)
    }
    
    public func addActions(_ actions: [URBNSwAlertAction]) {
        alertConfiguration.actions += actions
        let hasActiveAction = !actions.filter{$0.type != .passive}.isEmpty
        alertConfiguration.isActiveAlert = hasActiveAction
    }
    
    public func addTextfield(configurationHandler: ((UITextField) -> Void)) {
        alertConfiguration.isActiveAlert = true
        let tf = UITextField()
        alertConfiguration.textFields.append(tf)
        configurationHandler(tf)
    }
    
    public var textField: UITextField? {
        return alertConfiguration.textFields.first
    }
    
    public func textField(atIndex index: Int) -> UITextField? {
        guard index < alertConfiguration.textFields.count else { return nil }
        return alertConfiguration.textFields[index]
    }
    
    public func showTextFieldError(message: String) {
        alertView?.show(errorMessage: message)
    }
}

// MARK: Keyboard management
extension URBNSwAlertViewController {
    func keyboardWillShow(notif: Notification) {
        if let value = notif.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue, let av = alertView  {
            let kbFrame = value.cgRectValue
            let alertViewBottomYPos = av.height + av.frame.origin.y
            let offSet = -(alertViewBottomYPos - kbFrame.origin.y)
            if offSet < 0 {
                alertViewYContraint?.constant = offSet - 30
            }
            
            UIView.animate(withDuration: TimeInterval(0.1) , animations: { [unowned self] in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func keyboardWillHide(notif: Notification) {
        alertViewYContraint?.constant = 0
        
        UIView.animate(withDuration: TimeInterval(0.1) , animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.view.layoutIfNeeded()
        })
    }
}

enum URBNSwAlertType {
    case fullCustom, customView, customButton, fullStandard
}

