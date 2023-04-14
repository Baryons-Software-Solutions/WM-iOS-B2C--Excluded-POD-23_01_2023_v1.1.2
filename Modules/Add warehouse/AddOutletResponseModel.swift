//
//  AddOutletResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 02/09/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This AddOutletResponseModel  class used in  AddOutletWarehouseVC
import Foundation
// MARK: - AddOutletResponseModel
struct AddOutletResponseModel: Codable {
    let success: String
    let response: AddOutletResponse?
    let message: String
}

// MARK: - Response
struct AddOutletResponse: Codable {
    let id, outletName, phoneNumber, email: String
    let isDeleted, status: Int
    let statusName, createdBy, createdByID, updatedBy: String
    let updatedByID, updatedAt, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case outletName = "outlet_name"
        case phoneNumber = "phone_number"
        case email
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
