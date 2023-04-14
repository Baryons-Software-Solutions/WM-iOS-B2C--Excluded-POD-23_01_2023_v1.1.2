//
//  NewRegistrationVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 05/05/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class NewRegistrationVC: UIViewController {
  @IBOutlet weak var informationView: UIView!
  @IBOutlet weak var addressView: UIView!
  @IBOutlet weak var uploadView: UIView!
  
  @IBOutlet weak var infoSelectionVw: UIView!
  @IBOutlet weak var addressSelectionVw: UIView!
  @IBOutlet weak var uploadSelectionVw: UIView!
  
  @IBOutlet weak var tradeLicenseUploadView: CustomDashedView!
  @IBOutlet weak var trnCertificateUploadView: CustomDashedView!
  @IBOutlet weak var companyLogoUploadView: CustomDashedView!



    override func viewDidLoad() {
        super.viewDidLoad()
      self.informationView.isHidden = false
      self.addressView.isHidden = true
      self.uploadView.isHidden = true
      self.infoSelectionVw.backgroundColor = UIColor(hexFromString: "#ABC759")
    }
    
  @IBAction func InfoNextTapped(_ sender:UIButton){
    self.addressView.isHidden = false
    self.informationView.isHidden = true
    self.uploadView.isHidden = true
    self.addressSelectionVw.backgroundColor = UIColor(hexFromString: "#ABC759")
  }
  @IBAction func addressNextTapped(_ sender:UIButton){
    self.addressView.isHidden = true
    self.informationView.isHidden = true
    self.uploadView.isHidden = false
    self.uploadSelectionVw.backgroundColor = UIColor(hexFromString: "#ABC759")
  }
}
