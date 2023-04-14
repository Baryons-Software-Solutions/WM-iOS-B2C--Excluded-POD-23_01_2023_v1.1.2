//
//  Loginscreen.swift
//  Watermelon-iOS_GIT
//
//  Created by Baryons Dev on 13/09/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This Loginscreenclass used for after the registeration
import Foundation
import UIKit

protocol SuccessPopupDelegate : NSObjectProtocol{
    func globalButtonAction(_ sender:UIButton)
}

class Loginscreen: UIViewController {
    
    @IBOutlet weak var vwSuccessfull: UIView!
    @IBOutlet weak var btnloginnow  : UIButton!
    var customePopUpDelegate       : SuccessPopupDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwSuccessfull.cornerRadius  = 6
        self.btnloginnow.cornerRadius  = 6
    }
    @IBAction func btnloginnow(_ sender: UIButton) {
        self.dismiss(animated: false) {
            self.customePopUpDelegate?.globalButtonAction(sender)
        }
    }
}
