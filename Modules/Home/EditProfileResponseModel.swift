//
//  EditProfileResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 03/09/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This EditProdileResponseModel class used in MyProfileVC.
import Foundation
// MARK: - EditProdileResponseModel
struct EditProdileResponseModel: Codable {
    let success: String?
    let data: EditProdileResponse?
    let message: String?
}


// MARK: - DataClass
struct EditProdileResponse: Codable {
    let id, firstname, middlename, lastname: String?
    let phoneNumber, mobileNoCode, profile: String?
    let license: JSONNull?
    let userType: Int?
    let userTypeID: String?
    let roleID: Int?
    let designation, email, resetPasswordToken: String?
    let isDeleted, status: Int?
    let statusName, createdBy, updatedBy, createdByID: String?
    let updatedByID, permissionRoleID, permissionRoleName: String?
    let actionIDS: [String]?
    let updatedAt, createdAt: String?
    let outletIDS: [JSONAny]?
    let level, notified: String?
    let permission: String?
    let platform, tierApproval, valueFrom, valueTo: String?
    let fcmTokenAndroid, fcmTokenIos: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname, middlename, lastname
        case phoneNumber = "phone_number"
        case mobileNoCode = "mobile_no_code"
        case profile, license
        case userType = "user_type"
        case userTypeID = "user_type_id"
        case roleID = "role_id"
        case designation, email
        case resetPasswordToken = "reset_password_token"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdByID = "created_by_id"
        case updatedByID = "updated_by_id"
        case permissionRoleID = "permission_role_id"
        case permissionRoleName = "permission_role_name"
        case actionIDS = "action_ids"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case outletIDS = "outlet_ids"
        case level, notified, permission, platform
        case tierApproval = "tier_approval"
        case valueFrom = "value_from"
        case valueTo = "value_to"
        case fcmTokenAndroid = "fcm_token_android"
        case fcmTokenIos = "fcm_token_ios"
    }
}
