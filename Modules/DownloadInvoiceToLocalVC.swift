//
//  DownloadInvoiceToLocalVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Srinivas Prayag Sahu on 28/03/22.
// Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//
//This DownloadInvoiceToLocalVC used for genarate the downloaded pdf
import UIKit
import MBProgressHUD

class DownloadInvoiceToLocalVC: UIViewController, URLSessionDelegate {
    var invoiceId:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func downloadTapped(_ sender:UIButton){
        self.savePdf()
    }
    func savePdf() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let url = URL(string: "\(Constants.WebServiceURLs.DownloadInvoiceURL)\(self.invoiceId)")
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "WaterMelon Invoice-\(Int.random(in: 100...900)).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
                MBProgressHUD.hide(for: self.view, animated: true)
            } catch {
                print("Pdf could not be saved")
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
}
