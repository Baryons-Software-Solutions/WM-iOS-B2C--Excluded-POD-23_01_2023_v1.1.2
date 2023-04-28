//
//  TabbarViewController.swift
//  ThirdWave
//
//  Created by Meri on 13/09/19.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2019 Alchemy Digital LLP. All rights reserved.
//

import UIKit
import AudioToolbox

class TabbarViewController: UITabBarController {
    
    var badgelbl = UILabel()
    var previousController: UIViewController?
    var secondNavController: UINavigationController?
    var thirdNavController: UINavigationController?
    var settingNavController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setTabBarItems()
        UITabBarItem.appearance().badgeColor = .badgeCountColor
        
        // self.tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height + 0)
        
        let selectedColor = UIColor.blackThree
        let unselectedColor = UIColor.warmGrey
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor, NSAttributedString.Key.font: font(name: .robotoRegular, size: 8.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor, NSAttributedString.Key.font: font(name: .robotoRegular, size: 8.0)], for: .selected)
        
        self.tabBar.borderColor = .red
        
        if let items = self.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode( .alwaysOriginal )
                    self.tabBar(self.tabBar, didSelect: item)
                }
            }
        }
        if String(describing: USERDEFAULTS.getDataForKey(.user_type)) == "2" {
            viewControllers?.remove(at: 4)
            
        } else {
            // viewControllers?.remove(at: index)
            
            
        }
        // here you will notification for user is login or not
        
    }
    //Setting iniital image
    func setTabBarItems(){
        
        let myTabBarItem1 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "NewOrders")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let myTabBarItem2 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "NewMyCart")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let myTabBarItem3 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "Categories")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let myTabBarItem4 = (self.tabBar.items?[4])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "NewAccount")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let myTabBarItem5 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem5.image = UIImage(named:"Newhome")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        
    }
    
    @objc func goBack() {
        settingNavController?.popViewController(animated: true)
    }
    
    
    func setImageForProfileTab(tabbarItem: UITabBarItem, _ imageName: String, selectedImagaName: String) {
        if #available(iOS 13.0, *) { // for performance
            tabbarItem.image = UIImage.init(named: imageName, in: BUNDLE, with: nil)
        } else {
            // Fallback on earlier versions
            tabbarItem.image = UIImage.init(named: imageName)
        }
        if #available(iOS 13.0, *) { // for performance
            tabbarItem.selectedImage = UIImage.init(named: selectedImagaName, in: BUNDLE, with: nil)?.withRenderingMode(.alwaysOriginal)
        } else {
            // Fallback on earlier versions
            tabbarItem.selectedImage = UIImage.init(named: selectedImagaName)?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // set red as selected background color
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: 80)//tabBar.frame.height + 0)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor(hexFromString: "#EAECE3",alpha: 10), size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets.zero)
        
        // remove default border
        tabBar.frame.size.width = self.view.frame.width + 4
        tabBar.frame.origin.x = -2
        
    }
}

// MARK: - UITabBarControllerDelegate
extension TabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarAnimatedTransitioning()
    }
}

final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        destination.alpha = 0.0
        destination.transform = .init(scaleX: 1.0, y: 1.0)
        transitionContext.containerView.addSubview(destination)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
            destination.alpha = 1.0
            destination.transform = .identity
        }, completion: { transitionContext.completeTransition($0) })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
extension UIImage{
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x:0,y:0, width:size.width,height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
