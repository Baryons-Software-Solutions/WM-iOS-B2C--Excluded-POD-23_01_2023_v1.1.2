//
//  OutletListResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 02/09/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This OutletListResponseModel class used in MyCartDetailsViewController,DashBoardViewController,DeliveryVC,OutletVC.
import Foundation


// MARK: - OutletListResponseModel
struct OutletListResponseModel: Codable {
    let success: String
    let data: [OutletListResponse]?
    //   let totalCount: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, data
        //     case totalCount = "total_count"
        case message
    }
}

// MARK: - Datum
struct OutletListResponse: Codable {
    let id, outletName, address, phoneNumber: String
    let mobileNumber, countryCode, email, buyerID: String
    // let outletUser: [OutletUser]
    let outletLogo,statusName : String?
    let timeZone, typeOfBusiness, typeOfCuisine, otherFeatures: String?
    let tags, country, city, area: String
    let isDeleted, status: Int
    let createdBy, createdByID, updatedBy: String
    let updatedByID, updatedAt, createdAt: String?
    let billingAddress, billingArea, billingCity, billingCountry: String?
    let mobileCountryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case outletName = "outlet_name"
        case address
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
        case countryCode = "country_code"
        case email
        case buyerID = "buyer_id"
        //case outletUser = "outlet_user"
        case outletLogo = "outlet_logo"
        case timeZone = "time_zone"
        case typeOfBusiness = "type_of_business"
        case typeOfCuisine = "type_of_cuisine"
        case otherFeatures = "other_features"
        case tags, country, city, area
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case billingAddress = "billing_address"
        case billingArea = "billing_area"
        case billingCity = "billing_city"
        case billingCountry = "billing_country"
        case mobileCountryCode = "mobile_country_code"
    }
}

// MARK: - OutletUser
struct OutletUser: Codable {
    let id: String
    let firstname, createdDate, createdBy: String?
    let isSelected: Bool?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname
        case createdDate = "created_date"
        case createdBy = "created_by"
        case isSelected, title
    }
}


