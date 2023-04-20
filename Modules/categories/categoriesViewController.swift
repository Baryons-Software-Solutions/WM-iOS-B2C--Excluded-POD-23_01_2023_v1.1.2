//
//  categoriesViewController.swift
//  Watermelon-iOS_GIT
//
//  Created by Baryons on 21/11/22.
// Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class categoriesViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var CategoryView: UIView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var categoryHight: NSLayoutConstraint!
    
    var categoryList              = [GetCategoryList]()
    var arrOutletList             = [OutletListResponse]()
    var categoryBackGroundColor   = ["#EBF5D4","#C6F2E8","#FFEFCD","#FFD8D8"]
    var selectedCategoryIndex     : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.cornerRadius = 6
        categoryHight.constant = 2050
        searchTextField.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        registerCollectionViewXibs()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.wsSuppliersListURL(OutletId: outletID, search: "", fav_suppliers: "false", my_suppliers: "true", sort_method:"asc", sort_by:"company_name", app_type: "b2c", platform: "mobile", fcm_token_ios: "\(USERDEFAULTS.getDataForKey(.fcmToken))")
    }
    func registerCollectionViewXibs(){
        categoryCollection.register(UINib.init(nibName: "newCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newCategoriesCollectionViewCell")
    }
    //This function are used navigate the SearchScreen
    @objc func myTargetFunction() {
        print("It works!")
        let searchVC = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchText = self.searchTextField.text ?? ""
        searchVC?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
}
extension categoriesViewController {
    
    // Here we are calling supplier api to present all categories
    
    func wsSuppliersListURL(OutletId: String,search: String,fav_suppliers: String,my_suppliers:String,sort_method: String, sort_by: String, app_type: String, platform: String, fcm_token_ios: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            showToast(message: Constants.AlertMessage.NetworkConnection)
            return
        }
        var paramStr = ""
        paramStr = "start=0&end=10&page=1&sort_method=asc&keyword=&sort_by=company_name&outlet_id=\(OutletId)&my_suppliers=true&fav_suppliers=false&platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.newHomeUrl, requestPARAMS: paramStr, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success {
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(HomeScreenDataModel.self, from: responseData as! Data)
                        if dicResponseData.success == "1" {
                            self.categoryList = dicResponseData.getAllCategoryList
                            mycartCount = dicResponseData.mycartCount
                            if mycartCount == 0{
                                self.tabBarController?.tabBar.items![2].badgeValue = nil
                            }else{
                                self.tabBarController?.tabBar.items![2].badgeValue = "\(mycartCount)"
                            }
                            DispatchQueue.main.async {
                                self.categoryCollection.reloadData()
                            }
                            [self.categoryCollection].forEach({ (collectionView) in
                                collectionView?.delegate = self
                                collectionView?.dataSource = self
                            })
                            DispatchQueue.main.async {
                                self.categoryCollection.reloadData()
                            }
                        }
                    } catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showToast(message: Constants.AlertMessage.error)
                }
            }
        }
    }
}
//This method is creating the section
extension categoriesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollection{
            return categoryList.count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollection{
            let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "newCategoriesCollectionViewCell", for: indexPath) as? newCategoriesCollectionViewCell
            let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.categoryList[indexPath.row].categoryProfile)")
            cell?.catogoryImgView.kf.indicatorType = .activity
            cell?.catogoryImgView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "HomePlaceHolder"),
                options: nil)
            cell?.ProductName.text = "\(self.categoryList[indexPath.row].categoryName)"
            print( cell?.ProductName.text)
            cell?.imgBGView.layer.cornerRadius = 30
            cell?.imgBGView.layer.masksToBounds = true;
            cell?.imgBGView.layer.shadowColor = UIColor(hexFromString: "#FFFFFF").cgColor
            cell?.imgBGView.layer.shadowOpacity = 2.0
            cell?.imgBGView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            cell?.imgBGView.layer.shadowRadius = 6.0
            cell?.imgBGView.layer.masksToBounds = false
            return cell ?? UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    // This method is used for cliking the cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollection{
            let searchVC = menuStoryBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
            self.navigationItem.titleView?.isHidden = true
            searchVC?.categoryId = self.categoryList[indexPath.row].categoryID
            searchVC?.didSlectTapped = true
            searchVC?.hidesBottomBarWhenPushed = true
            searchVC?.placeHolderText = self.categoryList[indexPath.row].categoryName
            self.navigationController?.pushViewController(searchVC!, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollection{
            return CGSize(width: 90, height: 110)
        }else {
            return CGSize(width: 200 ,height: 200)
        }
    }
    
}
