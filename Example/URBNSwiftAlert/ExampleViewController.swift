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
    
    let genericCancelAction = URBNSwAlertAction(title: "Cancel", type: .cancel) { (action) in
        print("two button done pressed")
    }
    
    let genericDoneAction = URBNSwAlertAction(title: "Done", type: .normal) { (action) in
        print("one button alert action completed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
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
        
        let presentationView = UIView()
        presentationView.backgroundColor = .white
        presentationView.heightAnchor.constraint(equalToConstant: view.height/4).isActive = true
        presentationView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60).isActive = true
        
        let allElementsSV = UIStackView(arrangedSubviews: [activeAlertsLabel, activeButtonsSV, passiveAlertsLabel, passiveBtnsSV, presentationView])
        allElementsSV.spacing = 20
        allElementsSV.axis = .vertical
        allElementsSV.alignment = .center
        allElementsSV.distribution = .fillProportionally
        
        view.addSubviewsWithNoConstraints(allElementsSV)
        allElementsSV.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        activateVFL(format: "H:|-30-[allElementsSV]-30-|", views: ["allElementsSV": allElementsSV])
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
        customStyleAlert.alertStyler.titleFont = UIFont(name: "Chalkduster", size: 30) ?? UIFont.systemFont(ofSize: 12)
        customStyleAlert.show()
    }
    
    func showCustomViewAlert() {
        let customView = UIView()
        let iv = UIImageView(image: UIImage(named: "IMG_7016"))
        iv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        iv.contentMode = .scaleAspectFit
        let label = UILabel()
        label.text = "Cat In Box"
        let sv = UIStackView(arrangedSubviews: [iv, label])
        sv.wrap(in: customView, with: InsetConstraints(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), priority: UILayoutPriorityDefaultHigh))
        let customViewAlert = URBNSwAlertViewController(customView: customView)
        
        customViewAlert.addActions(genericCancelAction, genericDoneAction)
        customViewAlert.show()
    }
    
    func showQueuedAlerts() {
        
    }
    
    func showInputsAlert() {
        
    }
    
    func showFullCustomAlert() {
        
    }
    
    func showValidateInputAlert() {
        
    }
    
    func showSimpleLongPassiveAlert() {
        
    }
    
    func showSimpleShortPassiveAlert() {
    }
    
    func showPassiveCustomAlert() {
        
    }
    
    func showPassiveQueuedAlerts() {
        
    }
    
    func showFromModal() {
        
    }
    
    func showFromView() {
        
    }
}

extension ExampleViewController {
    var wrappingTitle: String {
        return "The Title of my message can be up to 2 lines long.  It wraps and centers."
    }
    var longMessage: String {
        return "And the message that is a bunch of text that will turn scrollable once the text view runs out of space.\nAnd the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text.  And the message that is a bunch of text. And the message that is a bunch of text. And the message that is a bunch of text."
    }
}
