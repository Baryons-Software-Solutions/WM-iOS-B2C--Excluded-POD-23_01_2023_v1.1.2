//
//  LoginResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 25/08/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This LoginResponseModel class used in LoginVC.
import Foundation

// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    let success: String?
    let data: LoginResponse?
    let message: String?
}

// MARK: - DataClass
struct LoginResponse: Codable {
    let id, firstname, middlename, lastname, profile: String?
    let phoneNumber, mobileNoCode: String?
    //  let userType: Int
    let userTypeID: String?
    let socialmediatype: String?
    //  let status: Int
    // let roleID: ValueWrapper?
    //   let permission: [String: Bool]
    let email, designation, tierApproval, level, buyerType: String?
    let value, notified, resetPasswordToken, platform: String?
    let isDeleted/*, status*/: Int
    let statusName, createdBy, updatedBy, createdByID: String?
    let updatedByID, updatedAt, createdAt, valueFrom: String?
    let valueTo: String?
    let company: Company
    let token, tokenType, expiresIn: String?
    let address, area, city, country, state,pincode: String?
    let billingAddress, billingArea, billingCity, billingCountry, billingState, billingPincode: String?
    let shippingAddress, shippingArea, shippingCity, shippingCountry, shippingState, shippingPincode: String?
    let billingAdd: Address? //Baryons-Surendra added on 24/01/22
    let shippingAdd: Address? //Baryons-Surendra added on 24/01/22
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname, middlename, lastname
        case phoneNumber = "phone_number"
        case mobileNoCode = "mobile_no_code"
        //   case userType = "user_type"
        case userTypeID = "user_type_id"
        //case roleID = "role_id"
        //case permission,
        case email, designation
        case tierApproval = "tier_approval"
        case level, value, notified
        case resetPasswordToken = "reset_password_token"
        case platform
        case isDeleted = "is_deleted"
        //    case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdByID = "created_by_id"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case valueFrom = "value_from"
        case valueTo = "value_to"
        case company, token, profile
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case buyerType = "buyer_type"
        case address
        case area, city, country, state, pincode
        case billingAddress = "billing_address"
        case billingArea = "billing_area"
        case billingCity = "billing_city"
        case billingCountry = "billing_country"
        case billingState = "billing_state"
        case billingPincode = "billing_pincode"
        case shippingAddress="shipping_address"
        case shippingArea = "shipping_area"
        case shippingCity = "shipping_city"
        case shippingCountry = "shipping_country"
        case shippingState = "shipping_state"
        case shippingPincode = "shipping_pincode"
        case billingAdd = "billing_details" //Baryons-Surendra added on 24/01/22
        case shippingAdd = "shipping_details" //Baryons-Surendra added on 24/01/22
        case socialmediatype = "social_media_type"
        
    }
}

// MARK: - Company
struct Company: Codable {
    let id, name, registrationNo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case registrationNo = "registration_no"
    }
}

struct Address: Codable {
    let address, city, country, country_code, pobox: String?
    
    enum CodingKeys: String, CodingKey {
        case address, city, country, country_code, pobox
    }
}
