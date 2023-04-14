//
//  CustomAlertVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 24/09/22.
// Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
// This CustomAlertVC class used for opening the popup success, error, and warning
import UIKit

enum popUpType {
    case success,error,warning
}

class CustomAlertVC: UIViewController {
    
    @IBOutlet weak var titleAlert: UILabel!
    @IBOutlet weak var messageAlert: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var alertImage: UIImageView!
    
    var message                 = ""
    var isSuccessResponse: Bool = true
    var buttonTitle              = "Continue"
    var popupmessageTypes : popUpType = .success
    var alertTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageAlert.text = "\(self.message)"
        completionButton.setTitle(buttonTitle, for: .normal)
        
        if !self.isSuccessResponse {
            self.alertImage.image = UIImage(named: "ios-close-circle-outline")
            titleAlert.text = "Error"
            completionButton.setTitle("Try Again", for: .normal)
        }
        if popupmessageTypes == .error{
            self.alertImage.image = UIImage(named: "ios-close-circle-outline")
            titleAlert.text = "Error"
            completionButton.setTitle("Try Again", for: .normal)
        }
        if !alertTitle.isEmpty{
            titleAlert.text = ""
            completionButton.setTitle("Continue", for: .normal)
        }
    }

    @IBAction func completionTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
