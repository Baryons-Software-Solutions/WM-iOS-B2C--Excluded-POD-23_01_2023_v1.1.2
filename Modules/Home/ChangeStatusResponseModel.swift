//
//  ChangeStatusResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 01/09/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This ChangeStatusResponseModel class used in ApiCall,FavouriteViewController,SupplierDetailsViewController,OutletVC.
import Foundation
// MARK: - ChangeStatusResponseModel
struct ChangeStatusResponseModel: Codable {
    let success: String
    let data: [JSONAny]?
    let message: String
}
