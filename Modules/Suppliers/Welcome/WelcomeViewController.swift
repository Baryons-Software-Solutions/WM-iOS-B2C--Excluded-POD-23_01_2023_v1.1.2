//
//  WelcomeViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 16/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var skipView                      : UIView!
    @IBOutlet weak var skipButton                    : UIButton!
    @IBOutlet weak var nextButton                    : UIButton!
    @IBOutlet weak var getStartedButton              : UIButton!
    @IBOutlet weak var onBoardingPageControl         : UIPageControl!
    @IBOutlet weak var skipBottomConstraint          : NSLayoutConstraint!
    @IBOutlet weak var onBoardingCollectionView      : UICollectionView!
    @IBOutlet weak var getStartedBottomConstraint    : NSLayoutConstraint!
    var DashBoard = MyOrdersViewController()
    var welcomeTitles            = ["Online Shopping","Add to Cart","Package Arrived"]
    var welocmeDescription       = ["Manage the entire supply ordering process from your phone","Handle your orders, process payments and generate invoices all in one place","Let the process flow smoothly and gain peace of mind"]
    let WelcomeImages            = ["1", "2", "3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        uiIntitilization()
        delegatesSetup()
    }
    func uiIntitilization(){
        self.getStartedButton.isHidden              = true
        self.getStartedBottomConstraint.constant    = -100
        self.onBoardingPageControl.numberOfPages    = welcomeTitles.count
    }
    func delegatesSetup(){
        let nib = UINib.init(nibName: "WelcomeCollectionViewCells", bundle: Bundle(for: WelcomeCollectionViewCells.self))
        onBoardingCollectionView.register(nib, forCellWithReuseIdentifier: "WelcomeCollectionViewCells")
    }
    @IBAction func getStartedbutton(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "is_Onboard_Completed")
        USERDEFAULTS.setDataForKey("false", .isLogin)
        USERDEFAULTS.setDataForKey("Guest", .user_first_name)
        USERDEFAULTS.setDataForKey("" , .user_last_name)
        let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
        dashboardvc?.selectedIndex = 0
        Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
    }
    @IBAction func skipButtonAction(_ sender: Any) {
        USERDEFAULTS.setDataForKey("false", .isLogin)
        USERDEFAULTS.setDataForKey("Guest", .user_first_name)
        USERDEFAULTS.setDataForKey("" , .user_last_name)
        let dashboardvc = mainStoryboard.instantiateViewController(withIdentifier: "TabbarViewController") as? UITabBarController
        dashboardvc?.selectedIndex = 0
        Constants.GlobalConstants.appDelegate.window?.rootViewController = dashboardvc
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        scrollToNextandPrevious(next: true)
    }
}
// MARK: Collection View handler
extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return welcomeTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onBoardingCollectionView.dequeueReusableCell(withReuseIdentifier: "WelcomeCollectionViewCells", for: indexPath)as? WelcomeCollectionViewCells
        cell?.onBoardingImageview.image   = UIImage(named: WelcomeImages[indexPath.item])
        cell?.titleLabel.text             = welcomeTitles[indexPath.item]
        cell?.descriptionLabel.text       = welocmeDescription[indexPath.item]
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.onBoardingCollectionView.frame.width, height: self.onBoardingCollectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pagenumber                           = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        let number                              = Int(pagenumber)
        self.onBoardingPageControl.currentPage  = number
        self.manageButtonAnimations(hideSkip: number == self.welcomeTitles.count - 1)
    }
    // MARK: Manage Button Animations of skip and start
    private func manageButtonAnimations(hideSkip: Bool) {
        UIView.animate(withDuration: 0.0, animations: {
        }) {  finished in
            if finished {
                self.skipView.isHidden = hideSkip
                self.getStartedButton.isHidden = !hideSkip
                if hideSkip{
                    self.skipBottomConstraint.constant = -150
                    self.getStartedBottomConstraint.constant = 20
                }else{
                    self.skipBottomConstraint.constant = 20
                    self.getStartedBottomConstraint.constant = -150
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    //MARK:- Scroll to next and previous cells
    func scrollToNextandPrevious(next:Bool){
        if let visibleCell = self.onBoardingCollectionView.indexPathsForVisibleItems.first{
            let nextIndex  = visibleCell.item + 1
            if nextIndex < 0{
                print("This is the first item")
                return
            }
            if next {
                let nextIndexPath = IndexPath(item: nextIndex, section: visibleCell.section)
                if  nextIndexPath.item < self.welcomeTitles.count{
                    if nextIndexPath.item == self.welcomeTitles.count - 1{
                        self.manageButtonAnimations(hideSkip: true)
                    }else{
                        self.manageButtonAnimations(hideSkip: false)
                    }
                    self.onBoardingPageControl.currentPage = nextIndex
                    self.onBoardingCollectionView.scrollToItem(at: nextIndexPath, at: !next ? .right : .left, animated: true)
                    return
                }
            }else{
                let nextIndexPath = IndexPath(item: welcomeTitles.count - 1, section: visibleCell.section)
                self.onBoardingPageControl.currentPage = nextIndex
                self.onBoardingCollectionView.scrollToItem(at: nextIndexPath, at: !next ? .right : .left, animated: true)
                self.manageButtonAnimations(hideSkip: true)
            }
        }
    }
}
