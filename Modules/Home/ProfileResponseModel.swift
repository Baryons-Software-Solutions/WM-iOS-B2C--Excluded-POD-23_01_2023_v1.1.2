//
//  ProfileResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 02/09/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

import Foundation
// MARK: - ProfileResponseModel
struct ProfileResponseModel: Codable {
    let success: String
    let data: [ProfileResponse]?
    let message: String
}

// MARK: - Datum
struct ProfileResponse: Codable {
    let id, firstname, middlename, lastname: String?
    let phoneNumber: String?
    let userType: Int?
    let userTypeID: String?
    let roleID: Int?
    let permission, email, resetPasswordToken: String?
    let isDeleted, status: Int?
    let statusName, createdBy, updatedBy, createdByID: String?
    let updatedByID, updatedAt, createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname, middlename, lastname
        case phoneNumber = "phone_number"
        case userType = "user_type"
        case userTypeID = "user_type_id"
        case roleID = "role_id"
        case permission, email
        case resetPasswordToken = "reset_password_token"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdByID = "created_by_id"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
