//
//  NotificationNameExtehsion.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
extension Notification.Name {
    static let newPostAdded = "AddPostObserver"
    static let appTimeout = Notification.Name("appTimeout")
    static let touchOnViewEvent = Notification.Name("UITouchEvent")
    public static let newNotificationArrived = Notification.Name(rawValue: "NewNotificationArrived")
    public static let changeUser = Notification.Name(rawValue: "NewNotificationArrived")
    public static let disableSelectedIndex = Notification.Name(rawValue: "ResetSelectedOrderIndex")
    static let appTillTimeOut = Notification.Name("TillTimeOut")
    public static let printerConnectDisconnectNotification = Notification.Name(rawValue: "printerConnectDisconnectNotifi")
    public static let updateProfileWaveCoinsWhenGetNotification = Notification.Name("updateProfileInfoWhenGetNotification")
}
