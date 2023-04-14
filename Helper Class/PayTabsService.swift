//
//  PayTabsService.swift
//  Watermelon-iOS_GIT
//
//  Created by Nevin Paul on 19/10/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//

import Foundation
import PaymentSDK
import UIKit

public class PayTabsService {
    
    static let currency: String = "AED"
    static let merchantCountryCode: String = "ae"
    static let showShippingInfo: Bool = true
    static let showBillingInfo: Bool = true
    static let screenTitle: String = "Pay with Card"
    
    // This method is used for payment tab background color, button color,etc
    static func getSDKTheme() -> PaymentSDKTheme {
        let theme = PaymentSDKTheme.default
        //  theme.logoImage = UIImage(named: "logo-payment")
        theme.backgroundColor = UIColor(hexFromString: "EFEFEF")
        theme.secondaryColor = .clear
        theme.buttonFontColor = .white
        theme.buttonColor = UIColor(hexFromString: "427D6C")
        theme.buttonFont = UIFont(name: "Dubai-Bold", size: 20)
        theme.titleFont = UIFont(name: "Dubai-Bold", size: 22)
        theme.secondaryFont = UIFont(name: "Dubai-Bold", size: 18)
        theme.primaryFont = UIFont(name: "Dubai-Regular", size: 18)
        
        return theme
    }
    // This method is used for genarate the profileID, serverKey, clientKey etc
    static func getSDKConfiguration() -> PaymentSDKConfiguration {
        let theme = getSDKTheme()
        let configuration = PaymentSDKConfiguration()
        let config: [String: String] = getConfig()
        
        configuration.profileID = config["profileID"] ?? ""
        configuration.serverKey = config["serverKey"] ?? ""
        configuration.clientKey = config["clientKey"] ?? ""
        configuration.currency = currency
        configuration.merchantCountryCode = merchantCountryCode
        configuration.showShippingInfo = showShippingInfo
        configuration.showBillingInfo = showBillingInfo
        configuration.screenTitle = screenTitle
        
        configuration.theme = theme
        return configuration
    }
    //This method is used for payment in the QA or Live API URL
    static func getConfig() -> [String: String] {
        var config: [String: String] = [:]
        //Need to enable below line, for Payments in the Live API URL
        let env = "prod"
        //Need to enable below line, for Payments in the QA API URL
        //let env = "dev"
        if env == "prod" {
            config["profileID"] = "80475"
            config["serverKey"] = "S9JNTL9MBK-J2HRHTD9TM-NZDZZM2KNG"
            config["clientKey"] = "CMKMKM-MPHP6M-HRH7DP-VGNGMV"
        } else {
            config["profileID"] = "72287"
            config["serverKey"] = "SGJNTL9MGT-JBTT9K6262-LTGWTBZLNZ"
            config["clientKey"] = "CHKMKM-MP7962-77PKGM-DTMHQD"
        }
        return config
    }
}
