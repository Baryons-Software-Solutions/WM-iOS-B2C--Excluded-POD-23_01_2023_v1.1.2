//
//  AddWarehouseResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 01/09/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This AddWarehouseResponseModel  class used in AddOutletWarehouseVC.
import Foundation
// MARK: - AddWarehouseResponseModel
struct AddWarehouseResponseModel: Codable {
    let success: String
    let data: AddWarehouseResponse?
    let message: String
}

// MARK: - DataClass


// MARK: - DataClass
struct AddWarehouseResponse: Codable {
    let warehouseName, address, phoneNumber, countryCode: String
    let mobileNumber: String
    let mobileCountryCode: String?
    let email, supplierID, warehouseUser: String
    let country, city, area: String?
    let warehouseUsername: String
    let isDeleted, status: Int
    let statusName, createdBy, createdByID, updatedBy: String
    let updatedByID, updatedAt, createdAt, id: String
    
    enum CodingKeys: String, CodingKey {
        case warehouseName = "warehouse_name"
        case address
        case phoneNumber = "phone_number"
        case countryCode = "country_code"
        case mobileNumber = "mobile_number"
        case mobileCountryCode = "mobile_country_code"
        case email
        case supplierID = "supplier_id"
        case warehouseUser = "warehouse_user"
        case country, city, area
        case warehouseUsername = "warehouse_username"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id = "_id"
    }
}
