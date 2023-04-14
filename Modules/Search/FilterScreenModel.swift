//
//  FilterScreenModel.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 13/09/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

struct PriceModel: Codable {
    let price: Double
    let filterName, id: String
    
    enum CodingKeys: String, CodingKey {
        case price
        case filterName = "filter_name"
        case id
    }
}



// MARK: - Welcome
struct SupplierFilterModel: Codable {
    let success: String
    let data: [Datum]
    let totalCount: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case totalCount = "total_count"
        case message
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: String
    let isOffline: Bool
    let companyName, companyRegistrationNo, address, country: String
    let city, pobox, firstname, middlename: String
    let lastname, profile, businessType, businessTypeOther: String
    let phoneNumberCode, mobileNoCode: String
    //    let noWarehouse: Int
    let phoneNumber, mobileNo, email, altEmail: String
    let password, wName, wAddress, wPhone: String
    let platform: String
    let adminRights: Int
    let approvalWorkflowSettings: String
    let isDeleted, status: Int
    let statusName: String
    let onBoardingStatus: Int
    let onBoardingStatusName, buyerSupplier, ownerBuyerNo, createdBy: String
    let updatedBy, createdByID, updatedByID, updatedAt: String
    let createdAt: String
    let defaultSetting: DefaultSettings
    let onBoardingAssignedTo, onBoardingAssignedToName, onBoardingDate: String
    //    let deliverySetting: DeliverySettings
    let isfavourit: String?
    let emailNotification, phoneNotification: Int
    let isblock: String?
    let ratings: Int
    let datumID: String
    let profileID, trnNo, license, trnCertificate: String?
    let userTypeID: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case isOffline = "is_offline"
        case companyName = "company_name"
        case companyRegistrationNo = "company_registration_no"
        case address, country, city, pobox, firstname, middlename, lastname, profile
        case businessType = "business_type"
        case businessTypeOther = "business_type_other"
        case phoneNumberCode = "phone_number_code"
        case mobileNoCode = "mobile_no_code"
        //        case noWarehouse = "no_warehouse"
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
        case approvalWorkflowSettings = "approval_workflow_settings"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case onBoardingStatus = "on_boarding_status"
        case onBoardingStatusName = "on_boarding_status_name"
        case buyerSupplier = "buyer_supplier"
        case ownerBuyerNo = "owner_buyer_no"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdByID = "created_by_id"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case defaultSetting = "default_setting"
        case onBoardingAssignedTo = "on_boarding_assigned_to"
        case onBoardingAssignedToName = "on_boarding_assigned_to_name"
        case onBoardingDate = "on_boarding_date"
        //        case deliverySetting = "delivery_setting"
        case isfavourit
        case emailNotification = "email_notification"
        case phoneNotification = "phone_notification"
        case isblock, ratings
        case datumID = "id"
        case profileID = "profile_id"
        case trnNo = "TRN_No"
        case license
        case trnCertificate = "trn_certificate"
        case userTypeID = "user_type_id"
    }
}

// MARK: - DefaultSetting
struct DefaultSettings: Codable {
    let countryCode, mobile: String?
    let email: String
    let contact: String?
    let countryCoded: String
    let contactNumber, contactEmail, accountDetails: String?
    let vatPercentage: String
    let includeInPricing: Bool
    //    let participateInMarketplace: Int?
    let displayForB2CBuyer: Bool?
    let descriptionOfCompany: String?
    let rfqEmail: String
    let otherAccountDetails, paytabsProfileID, alternameEmail2: String?
    let checkoutandPaytab: Bool?
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case mobile, email, contact
        case countryCoded = "country_coded"
        case contactNumber = "contact_number"
        case contactEmail = "contact_email"
        case accountDetails = "account_details"
        case vatPercentage = "vat_percentage"
        case includeInPricing = "include_in_pricing"
        //        case participateInMarketplace = "participate_in_marketplace"
        case displayForB2CBuyer = "display_for_b2c_buyer"
        case descriptionOfCompany = "description_of_company"
        case rfqEmail = "rfq_email"
        case otherAccountDetails = "other_account_details"
        case paytabsProfileID = "paytabs_profile_ID"
        case alternameEmail2 = "altername_email2"
        case checkoutandPaytab = "CheckoutandPaytab"
    }
}


// MARK: - DeliverySetting
struct DeliverySettings: Codable {
    let minimumOrderCurrency, minimumOrderValue, individualMinimumOrderCurrency, individualMinimumOrderValue: String
    let rejectOrderMinVal, deliveryFeeApplicable, deliveryFeeMinimumOrderCurrency, deliveryFeeMinimumOrderValue: String
    let deliveryFeeMinOrderApplicable, deliveryFeeMinOrderApplicableVal, individualDeliveryFeeMinOrderApplicableVal: String
    let doNotAllowBuyersToCancelOrder: String
    let countryID, cityID, areaID: [String]
    let status: String
    let cutOffTimes: [CutOffTime]
    
    enum CodingKeys: String, CodingKey {
        case minimumOrderCurrency = "minimum_order_currency"
        case minimumOrderValue = "minimum_order_value"
        case individualMinimumOrderCurrency = "individual_minimum_order_currency"
        case individualMinimumOrderValue = "individual_minimum_order_value"
        case rejectOrderMinVal = "reject_order_min_val"
        case deliveryFeeApplicable = "delivery_fee_applicable"
        case deliveryFeeMinimumOrderCurrency = "delivery_fee_minimum_order_currency"
        case deliveryFeeMinimumOrderValue = "delivery_fee_minimum_order_value"
        case deliveryFeeMinOrderApplicable = "delivery_fee_min_order_applicable"
        case deliveryFeeMinOrderApplicableVal = "delivery_fee_min_order_applicable_val"
        case individualDeliveryFeeMinOrderApplicableVal = "individual_delivery_fee_min_order_applicable_val"
        case doNotAllowBuyersToCancelOrder = "do_not_allow_buyers_to_cancel_order"
        case countryID = "country_id"
        case cityID = "city_id"
        case areaID = "area_id"
        case status
        case cutOffTimes = "cut_off_times"
    }
}


// MARK: - Welcome
struct FilterPricingModel: Codable {
    let success: String
    let data: [FilterProduct]
    let message: String
}

// MARK: - Datum
struct FilterProduct: Codable {
    let price: Double
    let filterName, id: String
    
    enum CodingKeys: String, CodingKey {
        case price
        case filterName = "filter_name"
        case id
    }
}

// MARK: - Welcome
struct FilterBrandModel: Codable {
    let success: String
    let data: [BrandFilter]
    let message: String
}

// MARK: - Datum
struct BrandFilter : Codable {
    let name: String
}

