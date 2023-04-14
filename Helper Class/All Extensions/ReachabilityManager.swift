//
//  ReachabilityManager.swift
//  NetworkStatusMonitor
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import Reachability // 1 Importing the Library

class ReachabilityManager: NSObject {
    static let shared = ReachabilityManager()  // 2. Shared instance
    
    // 5. Reachibility instance for Network status monitoring
    let reachability = Reachability()!

    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as? Reachability
        switch reachability?.connection {
        case .none:
            debugPrint("Network became unreachable")
            
            // display view for notrechable class
        case .wifi:
            debugPrint("Network reachable through WiFi")
            // remove view
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
            // remove view
        case .some(.none):
            break
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
    
    static func isReachable(completed: @escaping (ReachabilityManager) -> Void) {
        if ReachabilityManager.shared.reachability.connection != .none {
            completed(ReachabilityManager.shared)
        }
    }
    
    static func isUnreachable(completed: @escaping (ReachabilityManager) -> Void) {
        if ReachabilityManager.shared.reachability.connection == .none {
            completed(ReachabilityManager.shared)
        }
    }
}
