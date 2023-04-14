//
//  RatingsVC.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 31/03/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//

import UIKit
import Cosmos
class RatingsVC: UIViewController {
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var lblSupplierAddress: UILabel!
    @IBOutlet weak var lblSupplierName: UILabel!
    @IBOutlet weak var imgSupplier: UIImageView!
    @IBOutlet weak var btnTitle: UIButton!
    @IBOutlet weak var tblRatingList: UITableView!
    @IBOutlet weak var btnWriteReviewOut: UIButton!
    @IBOutlet weak var txtGiveComment: UITextField!
    @IBOutlet weak var vwWriteReview: UIView!
    @IBOutlet weak var vwGiveRating: CosmosView!
    @IBOutlet weak var vwBlur: UIView!
    @IBOutlet weak var btnSubmitReview: UIButton!
    
    var strSupplierName     = ""
    var strImage            = ""
    var strSupplierAddress  = ""
    var arrRatingList       = [Rating]()
    var page                = 1
    var isBottomRefresh     = false
    var responseCount       = 0
    var supplierId          = ""
    var selectedInvoiceID   = ""
    var rating              = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
    
    func initialization(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        self.btnWriteReviewOut.cornerRadius = 6
        self.btnSubmitReview.cornerRadius = 6
        self.lblSupplierName.text = self.strSupplierName
        self.lblSupplierAddress.text = self.strSupplierAddress
        let url = URL(string: "\(Constants.WebServiceURLs.fetchPhotoURL)\(strImage)")
        self.imgSupplier.kf.indicatorType = .activity
        self.imgSupplier.kf.setImage(
            with: url,
            placeholder: UIImage(named: "ic_placeholder"),
            options: nil)
        self.vwRating.rating = rating
        self.vwRating.text = "\(rating)"
        self.tblRatingList.tableFooterView = UIView()
        self.tblRatingList.register(UINib.init(nibName: "RatingTblCell", bundle: nil), forCellReuseIdentifier: "RatingTblCell")
        self.isBottomRefresh = false
        self.page = 1
        self.tblRatingList.refreshControl?.hideWithAnimation(hidden: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.wsRatingList()
    }
    // This method is used for invoke the rating API
    func wsRatingList(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection,isSuccessResponse: false)
            return
        }
        
        let postString = "fetch=100&page=\(page)&sort_method=&keyword=&sort_by=&supplier_id=\(supplierId)"
        APICall().post(apiUrl: Constants.WebServiceURLs.RatingsURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(RatingListResponseModel.self, from: responseData as! Data)
                        // success = true = 1 , unsuccess = false = 0
                        if dicResponseData.success == "1" {
                            self.page = 1
                            if self.isBottomRefresh == true {
                                self.tblRatingList.refreshControl?.hideWithAnimation(hidden: true)
                                self.arrRatingList.append(contentsOf: dicResponseData.data.ratings)
                            } else  {
                                self.arrRatingList = dicResponseData.data.ratings
                            }
                            self.isBottomRefresh = false
                            if self.arrRatingList.count > 0{
                                self.responseCount = dicResponseData.data.totalCount
                                self.tblRatingList.isHidden = false
                                self.lblNoData.isHidden = true
                            } else {
                                self.tblRatingList.isHidden = true
                                self.lblNoData.isHidden = false
                            }
                        } else {
                            self.tblRatingList.isHidden = true
                        }
                        DispatchQueue.main.async {
                            self.tblRatingList.delegate = self
                            self.tblRatingList.dataSource = self
                            self.tblRatingList.reloadData()
                        }
                    }catch let err {
                        print("Session Error: ",err)
                        self.lblNoData.isHidden = false
                        self.tblRatingList.isHidden = true
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    
    @IBAction func btnWriteReviewAct(_ sender: Any) {
        self.vwBlur.isHidden = false
        self.vwWriteReview.isHidden = false
        self.txtGiveComment.text = ""
        self.vwGiveRating.rating = 0
        self.vwGiveRating.text = "\(0)"
        self.selectedInvoiceID = self.arrRatingList[(sender as AnyObject).tag].id
    }
    @IBAction func btnBackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCloseRatingAct(_ sender: Any) {
        self.vwBlur.isHidden = true
        self.vwWriteReview.isHidden = true
    }
    @IBAction func btnSubmitReviewAct(_ sender: Any) {
        if vwGiveRating.rating == 0.0{
        self.showCustomAlert(message: "Rating is required",isSuccessResponse: false)
        } else  if self.selectedInvoiceID == "" {
            self.wsAddRating()
        } else {
            self.wsUpdateRating()
        }
        
        
    }
    // This method is used for adding the ratings
    func wsAddRating(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
    self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection,isSuccessResponse: false)
            return
        }
        
        let postString = "comments=\(self.txtGiveComment.text ?? "")&ratings=\(self.vwGiveRating.rating)&supplier_id=\(self.supplierId)"
        APICall().post(apiUrl: Constants.WebServiceURLs.CreateRatingURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(UpdateRatingListResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                       print(dicResponseData.message)
                        self.showCustomAlert(message: dicResponseData.message)
                        self.vwBlur.isHidden = true
                        self.vwWriteReview.isHidden = true
                        self.vwRating.rating = Double(dicResponseData.data.updatedRatings )
                        self.vwRating.text = "\(dicResponseData.data.updatedRatings)"
                        self.wsRatingList()
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for Updating the Ratings
    func wsUpdateRating(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection,isSuccessResponse: false)
            return
        }
        let postString = "comments=\(self.txtGiveComment.text ?? "")&ratings=\(self.vwGiveRating.rating)&id=\(self.selectedInvoiceID)"
        APICall().post(apiUrl: Constants.WebServiceURLs.UpdateRatingURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(UpdateRatingListResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        self.vwBlur.isHidden = true
                        self.vwWriteReview.isHidden = true
                        self.selectedInvoiceID = ""
                        self.vwRating.rating = Double(dicResponseData.data.updatedRatings )
                        self.vwRating.text = "\(dicResponseData.data.updatedRatings)"
                        self.wsRatingList()
                        
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    //This method is used for delete the rating
    func wsDeleteRating(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection,isSuccessResponse: false)
            return
        }
        let postString = "id=\(self.selectedInvoiceID)"
        
        APICall().post(apiUrl: Constants.WebServiceURLs.DeleteRatingURL, requestPARAMS: postString, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    
                    let decoder = JSONDecoder()
                    do {
                        
                        let dicResponseData = try decoder.decode(UpdateRatingListResponseModel.self, from: responseData as! Data)
                        self.showCustomAlert(message: dicResponseData.message)
                        self.selectedInvoiceID = ""
                        self.vwRating.rating = Double(dicResponseData.data.updatedRatings )
                        self.vwRating.text = "\(dicResponseData.data.updatedRatings)"
                        self.wsRatingList()
                        
                    }catch let err {
                        print("Session Error: ",err)
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error,isSuccessResponse: false)
                }
            }
        }
    }
    
}
// MARK: - UITableView Delegate Methods
    //This method is used for create table cell
extension RatingsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrRatingList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTblCell")! as! RatingTblCell
        if let buyerCompanyName = self.arrRatingList[indexPath.row].buyerCompanyName {
            cell.lblName.text = "\(buyerCompanyName)"
        }
        cell.lblDate.text = "\(self.arrRatingList[indexPath.row].createdAt.convertDateString(currentFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", extepectedFormat: "dd-MMM-yyyy hh:mm a"))"
        cell.lblComment.text =  self.arrRatingList[indexPath.row].comments?.rawValue
        cell.vwRating.rating =  Double(self.arrRatingList[indexPath.row].ratings)
        self.vwGiveRating.rating = Double(self.arrRatingList[indexPath.row].ratings)
        cell.btnEditRating.tag = indexPath.row
        cell.btnEditRating.addTarget(self , action:#selector(btnEditRatingClicked), for: .touchUpInside)
        cell.btnDeleteRating.tag = indexPath.row
        cell.btnDeleteRating.addTarget(self , action:#selector(btnDeleteClicked), for: .touchUpInside)
        if indexPath.row % 2 == 0{
            cell.backgroundColor = .whiteEleven
        } else {
            cell.backgroundColor = .white
        }
        return cell
        
    }
    
    @objc func btnEditRatingClicked(sender:UIButton) {
        self.txtGiveComment.text = self.arrRatingList[sender.tag].comments?.rawValue
        self.vwGiveRating.rating = Double(self.arrRatingList[sender.tag].ratings)
        self.selectedInvoiceID = self.arrRatingList[sender.tag].id
        self.vwBlur.isHidden = false
        self.vwWriteReview.isHidden = false
    }
    @objc func btnDeleteClicked(sender:UIButton) {
        self.selectedInvoiceID = self.arrRatingList[sender.tag].id
        self.wsDeleteRating()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    
    //MARK: - UIScrollView Method\
    //This method is used for scrolling purpose
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isBottomRefresh = true
        loadMoreFromBottom()
    }
    //This method is used for load more data
    func loadMoreFromBottom() {
        if responseCount > self.arrRatingList.count{
            page = page + 1
            self.tblRatingList.refreshControl?.showWithAnimation(onView: self.tblRatingList, animation: .bottom)
            self.wsRatingList()
            
        }
    }
}
