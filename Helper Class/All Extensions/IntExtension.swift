//
//  IntExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension Int {
    var scaledFontSize: CGFloat {
        var width = UIScreen.main.bounds.width // portrait
        if UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height {
            width = UIScreen.main.bounds.size.height // landscap
        }
        return CGFloat(self) * (width / (iPAD ? 750 : 320)) // 750 and 320 is 1x value respective ipad and iphone
    }
}

func getDifferenceDateForDeal(_ date: String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.timeZone = TimeZone.current
    //dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    let date1utc = dateFormatter.date(from: date) // end date in utc
    
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    
    let strDate1: String = dateFormatter.string(from: date1utc!) // end date in current time zone string
    
    let date = Date()
    let strDate2: String = dateFormatter.string(from: date) // current date in string
    
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    
    let date1 = formatter.date(from: strDate1)
    guard let date2 = formatter.date(from: strDate2) else { return 0 }
    
    let diffseconds = date1?.seconds(from: date2)
    return (diffseconds ?? 0)// (secs ?? 0)
}
