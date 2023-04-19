//
//  SupplierListResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 23/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This SupplierListResponseModel class used in  FavouritesViewController, SupplierViewController.
import Foundation
// MARK: - OutletListResponseModel
// MARK: - SupplierListResponseModel
struct SupplierListResponseModel: Codable {
    let success, message: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let totalCount: Int
    let suppliers: [SupplierListResponse]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case suppliers
    }
}

// MARK: - Supplier
struct SupplierListResponse: Codable {
    let id, companyName, companyRegistrationNo, address: String
    let country, city, pobox, firstname: String
    let middlename, lastname, profile, phoneNumberCode: String
    let mobileNoCode, phoneNumber, mobileNo, email: String
    let createdBy: String
    let isFavorite: Bool
    let isOffline: Bool
    let ratings: Double
    let profile_id: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case companyName = "company_name"
        case companyRegistrationNo = "company_registration_no"
        case address, country, city, pobox, firstname, middlename, lastname, profile
        case phoneNumberCode = "phone_number_code"
        case mobileNoCode = "mobile_no_code"
        case phoneNumber = "phone_number"
        case mobileNo = "mobile_no"
        case email
        case createdBy = "created_by"
        case isFavorite
        case isOffline = "is_offline"
        case ratings
        case profile_id
        
    }
}

struct SupplierListResponseModel1: Codable {
    let success: String
    let data: [SupplierListResponse]?
    let totalCount: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case totalCount = "total_count"
        case message
    }
}

// MARK: - Datum
struct SupplierListResponse1: Codable {
    let id, companyName, companyRegistrationNo, address: String
    let country, city, pobox, firstname: String
    let middlename, lastname, businessType: String
    //let businessTypeOther: String?
    let phoneNumberCode, mobileNoCode, noWarehouse, phoneNumber: String?
    let mobileNo, email, altEmail, password: String
    let wName, wAddress, wPhone, platform: String
    let adminRights, isDeleted, status: Int
    let statusName: String
    let buyerSupplier: String?
    let buyerID: [BuyerID]?
    let profile, isfavourit: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case companyName = "company_name"
        case companyRegistrationNo = "company_registration_no"
        case address, country, city, pobox, firstname, middlename, lastname
        case businessType = "business_type"
        case phoneNumberCode = "phone_number_code"
        case mobileNoCode = "mobile_no_code"
        case noWarehouse = "no_warehouse"
        case phoneNumber = "phone_number"
        case mobileNo = "mobile_no"
        case email
        case altEmail = "alt_email"
        case password
        case wName = "w_name"
        case wAddress = "w_address"
        case wPhone = "w_phone"
        case platform
        case adminRights = "admin_rights"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case buyerSupplier = "buyer_supplier"
        case buyerID = "buyer_id"
        case profile, isfavourit
    }
}

enum ApprovalWorkflowSettingsUnion: Codable {
    case approvalWorkflowSettingsClass(ApprovalWorkflowSettingsClass)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ApprovalWorkflowSettingsClass.self) {
            self = .approvalWorkflowSettingsClass(x)
            return
        }
        throw DecodingError.typeMismatch(ApprovalWorkflowSettingsUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ApprovalWorkflowSettingsUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .approvalWorkflowSettingsClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ApprovalWorkflowSettingsClass
struct ApprovalWorkflowSettingsClass: Codable {
    let tierBased: [TierBased]
    
    enum CodingKeys: String, CodingKey {
        case tierBased = "tier_based"
    }
}

// MARK: - TierBased
struct TierBased: Codable {
    let level, status, createdDate, createdBy: String
    let updatedDate, updatedBy: String
    
    enum CodingKeys: String, CodingKey {
        case level, status
        case createdDate = "created_date"
        case createdBy = "created_by"
        case updatedDate = "updated_date"
        case updatedBy = "updated_by"
    }
}

// MARK: - BuyerID
struct BuyerID: Codable {
    let id, name, createdDate: String
    let createdBy: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdDate = "created_date"
        case createdBy = "created_by"
    }
}

// MARK: - DefaultSetting
struct DefaultSetting: Codable {
    let mobile, email, contact /*accountDetails*/: String
 //   let vatPercentage: ValueWrapper
 //   let descriptionOfCompany: String
    
    enum CodingKeys: String, CodingKey {
        case mobile, email, contact
      //  case accountDetails = "account_details"
    //    case vatPercentage = "vat_percentage"
   //     case descriptionOfCompany = "description_of_company"
    }
}

enum customdataType: Codable {
    case array([String])
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .array(container.decode(Array.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(customdataType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .array(let array):
            try container.encode(array)
        case .string(let string):
            try container.encode(string)
        }
    }
}

// MARK: - DeliverySetting
struct DeliverySetting: Codable {
    let minimumOrderCurrency, minimumOrderValue, deliveryFeeApplicable: String
    //    let rejectOrderMinVal: String?
    let deliveryFeeMinimumOrderCurrency, deliveryFeeMinimumOrderValue, deliveryFeeMinOrderApplicable, deliveryFeeMinOrderApplicableVal: String
    let doNotAllowBuyersToCancelOrder: ValueWrapper?
    let countryID, cityID: customdataType
    let areaID: customdataType
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case minimumOrderCurrency = "minimum_order_currency"
        case minimumOrderValue = "minimum_order_value"
        //        case rejectOrderMinVal = "reject_order_min_val"
        case deliveryFeeApplicable = "delivery_fee_applicable"
        case deliveryFeeMinimumOrderCurrency = "delivery_fee_minimum_order_currency"
        case deliveryFeeMinimumOrderValue = "delivery_fee_minimum_order_value"
        case deliveryFeeMinOrderApplicable = "delivery_fee_min_order_applicable"
        case deliveryFeeMinOrderApplicableVal = "delivery_fee_min_order_applicable_val"
        case doNotAllowBuyersToCancelOrder = "do_not_allow_buyers_to_cancel_order"
        case countryID = "country_id"
        case cityID = "city_id"
        case areaID = "area_id"
        case status
    }
}

enum Area: String, Codable {
    case alBaraha = "Al Baraha"
    case alBarari = "Al Barari"
    case alFurjan = "Al Furjan"
}

// MARK: - CutOffTime
struct CutOffTime: Codable {
    let deliver: String
    let days: String
    let earlier: String
}

// MARK: - OutletsSetting
struct OutletsSetting: Codable {
    let id, outletName, address, phoneNumber: String
    let mobileNumber, email, timeZone, country: String
    let city: String
    let area: Area
    
    enum CodingKeys: String, CodingKey {
        case id
        case outletName = "outlet_name"
        case address
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
        case email
        case timeZone = "time_zone"
        case country, city, area
    }
}

