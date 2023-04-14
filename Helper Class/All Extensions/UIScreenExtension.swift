//
//  UIScreenExtension.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
// Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//

//This method is used for screen Extension
import UIKit

extension UIScreen {
    public func setBrightness(to value: CGFloat, duration: TimeInterval = 0.3, ticksPerSecond: Double = 120) {
        let startingBrightness = UIScreen.main.brightness
        let delta = value - startingBrightness
        let totalTicks = Int(ticksPerSecond * duration)
        let changePerTick = delta / CGFloat(totalTicks)
        let delayBetweenTicks = 1 / ticksPerSecond
        
        let time = DispatchTime.now()
        
        for i in 1...totalTicks {
            DispatchQueue.main.asyncAfter(deadline: time + delayBetweenTicks * Double(i)) {
                UIScreen.main.brightness = max(min(startingBrightness + (changePerTick * CGFloat(i)), 1), 0)
            }
        }
    }
}
