
//  ProductImageViewController.swift
//  Watermelon-iOS_GIT
//  Created by Baryons on 04/01/23.
// Updated by Avinash on 11/03/23.
//  Copyright © 2023 Mac. All rights reserved.
//
import UIKit

class ProductImageViewController: UIViewController {
    
    @IBOutlet weak var BtnBack: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    var defaultImageurl     : URL?
    var productDetails      :ProductDetailsResponseModel?
    var prdId               = ""
    var arrImages:[String]  = ["Californian Almonds", "Farmely Almond", "Icon feather-calendar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
    }
    override func viewDidAppear(_ animated: Bool) {
        getProductDetails(proudctId: prdId)
        print(prdId)
    }
    func setUpScrollView(){
        ScrollView.delegate = self
    }
    
    @IBAction func BtnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    //This methos is invoking the product details
    func getProductDetails(proudctId: String){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.showCustomAlert(message: Constants.AlertMessage.NetworkConnection, isSuccessResponse: false)
            return
        }
        let param = "product_id=\(proudctId)"
        print(param)
        APICall().post(apiUrl: Constants.WebServiceURLs.ProductDetailsURL, requestPARAMS: param, isTimeOut: false){
            (success, responseData) in DispatchQueue.main.async {
                if success{
                    let decoder = JSONDecoder()
                    do {
                        let dicResponseData = try decoder.decode(ProductDetailsResponseModel.self, from: responseData as! Data)
                        self.productDetails = dicResponseData
                        let url = URL(string: "\(Constants.WebServiceURLs.fetchProductDetailsPhotoURL)\(self.productDetails?.data?.product?.product_image ?? "")")
                        self.ImageView?.kf.indicatorType = .activity
                        self.ImageView?.kf.setImage(
                            with: url,
                            placeholder: UIImage(named: "Californian Almonds"),
                            options: nil)
                        let priceValue = self.productDetails?.data?.product?.pricing_range?[0].ref!
                        let quatity = (self.productDetails?.data?.product?.pricing_range?[0].quantity_already_in_cart ?? 0.0)
                        
                    }catch let err {
                        print("Session Error: ",err)
                        self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false,buttonTitle: "Try again")
                    }
                }
                else{
                    self.showCustomAlert(message: Constants.AlertMessage.error, isSuccessResponse: false)
                }
            }
        }
    }
}
//This method is used for to creating the table view
extension ProductImageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ImageView
    }
}

