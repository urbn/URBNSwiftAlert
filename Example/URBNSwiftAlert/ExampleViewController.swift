//
//  ViewController.swift
//  URBNSwiftAlert
//
//  Created by Kevin Taniguchi on 05/23/2017.
//  Copyright (c) 2017 Kevin Taniguchi. All rights reserved.
//

import UIKit
import URBNConvenience
import URBNSwiftAlert

class ExampleViewController: UIViewController {
    let presentationView = UIView()
    let modalButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        layoutExampleButtons()
    }
    
    func showOneButtonAlert() {
        let oneBtnAlert = URBNSwAlertViewController(title: wrappingTitle, message: longMessage)
        oneBtnAlert.addActions(genericDoneAction)
        oneBtnAlert.show()
    }
    
    func showTwoBtnAlert() {
        let twoBtnAlert = URBNSwAlertViewController(title: wrappingTitle, message: longMessage)
        twoBtnAlert.addActions([genericCancelAction, genericDoneAction])
        twoBtnAlert.show()
    }
    
    func showCustomStyleAlert() {
        let customStyleAlert = URBNSwAlertViewController(title: "Custom Styled Alert", message: "You can change fonts, colors, buttons, size, corner radius, and more.")
        customStyleAlert.addActions([genericCancelAction, genericDoneAction])
        customStyleAlert.alertStyler.backgroundColor = .orange
        customStyleAlert.alertStyler.standardAlertViewInsets = UIEdgeInsets(top: 2, left: 40, bottom: 20, right: 10)
        customStyleAlert.alertStyler.titleFont = UIFont(name: "Chalkduster", size: 30) ?? UIFont.systemFont(ofSize: 12)
        customStyleAlert.show()
    }
    
    func showCustomViewAlert() {
        let customViewAlert = URBNSwAlertViewController(customView: customView)
        customViewAlert.addActions(genericCancelAction, genericDoneAction)
        customViewAlert.show()
    }
    
    func showQueuedAlerts() {
        let firstAlert = URBNSwAlertViewController(title: "I'm the first alert", message: longMessage)
        firstAlert.addActions(genericDoneAction)
        firstAlert.show()
        
        let secondAlert = URBNSwAlertViewController(title: "I'm the second alert", message: longMessage)
        secondAlert.alertStyler.backgroundColor = .brown
        secondAlert.alertStyler.titleFont = UIFont(name: "Chalkduster", size: 30) ?? UIFont.systemFont(ofSize: 12)
        secondAlert.addActions(genericCancelAction, genericDoneAction)
        secondAlert.show()
        
        let thirdAlert = URBNSwAlertViewController(title: "I'm the third alert", message: "Short message", customButtons: ExampleCustomButtons())
        thirdAlert.show()
    }
    
    func showInputsAlert() {
        let textFieldsAlert = URBNSwAlertViewController(title: "Textfields Alert", message: "Enter some info:")
        
        textFieldsAlert.addTextfield { (textField) in
            textField.borderStyle = .line
            textField.placeholder = "Email"
        }
        
        textFieldsAlert.addTextfield { (textField) in
            textField.borderStyle = .line
            textField.placeholder = "Password"
        }
        
        textFieldsAlert.addTextfield { (textField) in
            textField.borderStyle = .line
            textField.placeholder = "Confirm"
        }

        let textFieldsAlertAction = URBNSwAlertAction(title: "Done", type: .normal) { (action) in
            print("textfield 0 \(textFieldsAlert.textField?.text ?? "")")
            print("textfield 1 \(textFieldsAlert.textField(atIndex: 1)?.text ?? "")")
            print("textfield 2 \(textFieldsAlert.textField(atIndex: 2)?.text ?? "")")
        }
        
        textFieldsAlert.addActions(textFieldsAlertAction)
        textFieldsAlert.show()
    }
    
    func showFullCustomAlert() {
        let customButtons = ExampleCustomButtons()
        let fullCustomViewAlert = URBNSwAlertViewController(customView: customView, customButtons: customButtons)
        fullCustomViewAlert.show()
    }
    
    func showValidateInputAlert() {
        
    }
    
    func showSimpleLongPassiveAlert() {
        let passiveAlert = URBNSwAlertViewController(title: "Simple Passive", message: longMessage)
        passiveAlert.alertConfiguration.touchOutsideToDismiss = true
        
        let passiveAction = URBNSwAlertAction(type: .passive) { (action) in
            print("long passive action")
        }
        
        passiveAlert.addActions(passiveAction)
        passiveAlert.show()
    }
    
    func showSimpleShortPassiveAlert() {
        let passiveAlert = URBNSwAlertViewController(title: "Simple Passive", message: "Very short alert. Minimum 2 second duration.")
        passiveAlert.alertConfiguration.touchOutsideToDismiss = true
        passiveAlert.alertConfiguration.duration = 2.0
        passiveAlert.show()
    }
    
    func showPassiveCustomAlert() {
        let passiveCustomAlert = URBNSwAlertViewController(customView: customView)
        passiveCustomAlert.alertConfiguration.duration = 5.0
        passiveCustomAlert.alertConfiguration.touchOutsideToDismiss = true
        passiveCustomAlert.show()
    }
    
    func showPassiveQueuedAlerts() {
        let firstPassiveAlert = URBNSwAlertViewController(title: "First Alert", message: "Will auto dismiss in 3 seconds")
        firstPassiveAlert.alertConfiguration.touchOutsideToDismiss = true
        firstPassiveAlert.alertConfiguration.duration = 3.0
        
        let secondPassiveAlert = URBNSwAlertViewController(customView: customView)
        secondPassiveAlert.alertConfiguration.touchOutsideToDismiss = true
        let secondAction = URBNSwAlertAction(type: .passive) { (action) in
            print("second passive action")
        }
        secondPassiveAlert.addActions(secondAction)
        
        let thirdPassiveAlert = URBNSwAlertViewController(title: "Final alert", message: "Touch to dismiss")
        thirdPassiveAlert.alertConfiguration.touchOutsideToDismiss = true
        
        firstPassiveAlert.show()
        secondPassiveAlert.show()
        thirdPassiveAlert.show()
    }
    
    func showFromModal() {
        let vc = ExampleViewController()
        let nav = UINavigationController(rootViewController: vc)
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closePressed))
        present(nav, animated: true, completion: nil)
    }
    
    func showFromView() {
        let customViewAlert = URBNSwAlertViewController(customView: customView)
        customViewAlert.show(inView: presentationView)
    }
    
    func closePressed() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Layout Example Buttons
extension ExampleViewController {
    func layoutExampleButtons() {
        let btnsMapper: ([String: Selector], UIColor) -> [UIButton] = { (dict, color) in
            return dict.map({ (entry) -> UIButton in
                let btn = UIButton(type: .custom)
                btn.setTitle(entry.key, for: .normal)
                btn.addTarget(self, action: entry.value, for: .touchUpInside)
                btn.backgroundColor = color
                btn.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                return btn
            })
        }
        
        let leftActiveBtns = btnsMapper(["One Button": #selector(ExampleViewController.showOneButtonAlert),
                                         "Two Buttons": #selector(ExampleViewController.showTwoBtnAlert),
                                         "Custom Style": #selector(ExampleViewController.showCustomStyleAlert),
                                         "Custom View": #selector(ExampleViewController.showCustomViewAlert)
            ], .blue)
        
        let leftActivBtnsSV = UIStackView(arrangedSubviews: leftActiveBtns)
        leftActivBtnsSV.axis = .vertical
        leftActivBtnsSV.spacing = 10
        
        let rightActiveBtns = btnsMapper(["Queued Alerts ": #selector(ExampleViewController.showQueuedAlerts),
                                          "Inputs": #selector(ExampleViewController.showInputsAlert),
                                          "Full Custom": #selector(ExampleViewController.showFullCustomAlert),
                                          "Validate": #selector(ExampleViewController.showValidateInputAlert)
            ], .blue)
        
        let rightActiveBtnsSV = UIStackView(arrangedSubviews: rightActiveBtns)
        rightActiveBtnsSV.axis = .vertical
        rightActiveBtnsSV.spacing = 10
        
        let activeButtonsSV = UIStackView(arrangedSubviews: [leftActivBtnsSV, rightActiveBtnsSV])
        activeButtonsSV.spacing = 30
        
        let topPassiveBtns = btnsMapper(["Simple Long": #selector(ExampleViewController.showSimpleLongPassiveAlert),
                                         "Simple Short": #selector(ExampleViewController.showSimpleShortPassiveAlert)
            ], .brown)
        
        let bottomPassiveBtns = btnsMapper(["Custom View": #selector(ExampleViewController.showPassiveCustomAlert),
                                            "Queued Alerts": #selector(ExampleViewController.showPassiveQueuedAlerts)
            ], .brown)
        
        let topPassiveBtnsSV = UIStackView(arrangedSubviews: topPassiveBtns)
        topPassiveBtnsSV.spacing = 10
        topPassiveBtnsSV.axis = .vertical
        let bottomPassiveBtnsSV = UIStackView(arrangedSubviews: bottomPassiveBtns)
        bottomPassiveBtnsSV.spacing = 10
        bottomPassiveBtnsSV.axis = .vertical
        
        let passiveBtnsSV = UIStackView(arrangedSubviews: [topPassiveBtnsSV, bottomPassiveBtnsSV])
        passiveBtnsSV.spacing = 30
        
        let activeAlertsLabel = UILabel()
        activeAlertsLabel.text = "Active Alerts"
        
        let passiveAlertsLabel = UILabel()
        passiveAlertsLabel.text = "Passive Alerts"
        
        presentationView.backgroundColor = .white
        presentationView.heightAnchor.constraint(equalToConstant: view.height/3).isActive = true
        presentationView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        if let presentFromViewBtn = btnsMapper(["Show in View": #selector(ExampleViewController.showFromView)], .green).first {
            presentFromViewBtn.wrap(in: presentationView, with: InsetConstraints(insets:  UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), priority: UILayoutPriorityDefaultHigh))
        }
        
        modalButton.setTitle("From Modal", for: .normal)
        modalButton.backgroundColor = .magenta
        modalButton.addTarget(self, action: #selector(showFromModal), for: .touchUpInside)
        
        let allElementsSV = UIStackView(arrangedSubviews: [activeAlertsLabel, activeButtonsSV, passiveAlertsLabel, passiveBtnsSV, modalButton, presentationView])
        allElementsSV.spacing = 20
        allElementsSV.axis = .vertical
        allElementsSV.alignment = .center
        allElementsSV.distribution = .fillProportionally
        
        view.addSubviewsWithNoConstraints(allElementsSV)
        allElementsSV.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        activateVFL(format: "H:|[allElementsSV]|", views: ["allElementsSV": allElementsSV])
    }
}

// MARK: Convenience
extension ExampleViewController {
    var genericCancelAction: URBNSwAlertAction {
        return URBNSwAlertAction(title: "Cancel", type: .cancel) { (action) in
            print("two button done pressed")
        }
    }
    
    var genericDoneAction: URBNSwAlertAction {
        return URBNSwAlertAction(title: "Done", type: .normal) { (action) in
            print("one button alert action completed")
        }
    }
    
    var wrappingTitle: String {
        return "The Title of my message can be up to 2 lines long.  It wraps and centers."
    }
    
    var longMessage: String {
        return "And the message that is a bunch of text that will turn scrollable once the text view runs out of space.\nAnd the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text."
    }
    
    var customView: UIView {
        let customView = UIView()
        customView.backgroundColor = .green
        let iv = UIImageView(image: UIImage(named: "IMG_7016"))
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        iv.contentMode = .scaleAspectFit
        let label = UILabel()
        label.text = "Cat In Box"
        let sv = UIStackView(arrangedSubviews: [iv, label])
        sv.spacing = 20
        sv.wrap(in: customView, with: InsetConstraints(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), priority: UILayoutPriorityDefaultHigh))
        
        return customView
    }
}

class ExampleCustomButtons: UIView, URBNSwAlertButtonContainer {
    var containerView: UIView {
        return self
    }

    var actions: [URBNSwAlertAction] {
        let firstAction = URBNSwAlertAction(customButton: myFirstCustomButton) { (action) in
            print("custom 1 button action")
        }
        
        let secondAction = URBNSwAlertAction(customButton: mySecondCustomButton) { (action) in
            print("custom 2 button action")
        }
        
        return [firstAction, secondAction]
    }
    
    let myFirstCustomButton: UIButton
    let mySecondCustomButton: UIButton
    
    override init(frame: CGRect) {
        myFirstCustomButton = UIButton(type: .custom)
        myFirstCustomButton.backgroundColor = .cyan
        myFirstCustomButton.setImage(UIImage(named: "ExampleCancel"), for: .normal)
        myFirstCustomButton.setTitle("Cancel", for: .normal)
        myFirstCustomButton.imageView?.contentMode = .scaleAspectFit
        mySecondCustomButton = UIButton(type: .custom)
        mySecondCustomButton.setTitle("Done", for: .normal)
        mySecondCustomButton.imageView?.contentMode = .scaleAspectFit
        mySecondCustomButton.backgroundColor = .purple
        
        let customTopDivider = UIView()
        customTopDivider.backgroundColor = .orange
        customTopDivider.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        let customButtonDivider = UIView()
        customButtonDivider.backgroundColor = .magenta
        
        let buttonsContainer = UIView()
        let buttons = ["myFirstCustomButton": myFirstCustomButton, "customButtonDivider": customButtonDivider, "mySecondCustomButton": mySecondCustomButton]
        buttonsContainer.addSubviewsWithNoConstraints(myFirstCustomButton, customButtonDivider, mySecondCustomButton)
        activateVFL(format: "H:|[myFirstCustomButton][customButtonDivider(5)][mySecondCustomButton(myFirstCustomButton)]|", options:[.alignAllTop, .alignAllBottom], views: buttons)
        activateVFL(format: "V:|[myFirstCustomButton(44)]|", views: buttons)
        
        let sv = UIStackView(arrangedSubviews: [customTopDivider, buttonsContainer])
        sv.axis = .vertical
        
        super.init(frame: frame)
        
        sv.wrap(in: self, with: InsetConstraints(insets: UIEdgeInsets.zero, priority: UILayoutPriorityDefaultHigh))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
