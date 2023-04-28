//
//  ItemDetailResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 23/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This ItemDetailResponseModel class used in WishlistViewController,SupplierDetailsViewController,searchViewController.
import Foundation




// MARK: - ItemDetailResponseModel
struct ItemDetailResponseModel: Codable {
    let success, message: String
    let data: ItemDetailResponse
}

// MARK: - DataClass
struct ItemDetailResponse: Codable {
    let totalCount: Int
    var products: [Product]
    let supplierInfo: DataSupplierInfo?
    let supplierCategoryList: [CategoryInfo]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case products
        case supplierInfo = "supplier_info"
        case supplierCategoryList = "supplier_category_list"
    }
}

// MARK: - Product
struct Product: Codable {
    let id, productImage, productCode, productName: String
    let brand, categoryID, categoryName, subcategoryID: String
    let subcategoryName, baseUom: String
    let orderingOption: [OrderingOption]?
    let countryOfOrigin, upcEanNo: String
    let certification: [JSONAny]
    let displayPrice: ValueWrapper?
    let pricingRange: [PricingRange]
    let rfq, userTypeID: String
    //  let popularity: Int
    let supplierInfo: ProductSupplierInfo
    //  let profileId:Int
    var wishListStatus : Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case wishListStatus =  "wishlist_status"
        case productImage = "product_image"
        case productCode = "product_code"
        case productName = "product_name"
        case brand
        case categoryID = "category_id"
        case categoryName = "category_name"
        case subcategoryID = "subcategory_id"
        case subcategoryName = "subcategory_name"
        case baseUom = "base_uom"
        case orderingOption = "ordering_option"
        case countryOfOrigin = "country_of_origin"
        case upcEanNo = "upc_ean_no"
        case certification
        case displayPrice = "display_price"
        case pricingRange = "pricing_range"
        case rfq
        case userTypeID = "user_type_id"
        // case popularity
        case supplierInfo = "supplier_info"
        //  case profileId = "profile_id"
    }
}

// MARK: - OrderingOption
struct OrderingOption: Codable {
    let orderunit: ValueWrapper?
    let equalsto: ValueWrapper?
}

// MARK: - PricingRange
struct PricingRange: Codable {
    let id: String
    let pricingRangeDefault: ValueWrapper?
    let priceunit: ValueWrapper?
    let pricemoq: ValueWrapper?
    let ref, promo: ValueWrapper?
    let skuStatus: ValueWrapper?
    let isuom: Bool
    let displaySkuName: String
    let originalPrice: Double
    let discountPercentange: Double
    let listPrice, discountAmount: ValueWrapper?
    let equalsto, quantityAlreadyInCart: ValueWrapper?
    let cartID: ValueWrapper?
    let supplierId : String
    //   let ProductAvailabilityInCart: Bool
    enum CodingKeys: String, CodingKey {
        case id
        case supplierId           = "supplier_id"
        case pricingRangeDefault = "default"
        case priceunit, pricemoq, ref, promo
        case skuStatus = "sku_status"
        case isuom
        case displaySkuName = "display_sku_name"
        case originalPrice = "original_price"
        case discountPercentange = "discount_percentange"
        case discountAmount = "discount_amount"
        case listPrice = "list_price"
        case equalsto
        case quantityAlreadyInCart = "quantity_already_in_cart"
        case cartID = "cart_id"
        //   case ProductAvailabilityInCart = "product_availability_in_cart"
    }
}

// MARK: - ProductSupplierInfo
struct ProductSupplierInfo: Codable {
    let id, companyName, companyRegistrationNo, address: String
    let country, city, pobox, firstname: String
    let middlename, lastname, profile, phoneNumberCode: String
    let mobileNoCode, phoneNumber, mobileNo, email: String
    let createdBy: String
    let ratings: Double
    
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
        case ratings
    }
}

// MARK: - DataSupplierInfo
struct DataSupplierInfo: Codable {
    let id: String
    //  let isOffline: Bool
    let companyName, companyRegistrationNo, address, country: String
    let city, pobox, firstname, middlename: String
    let lastname, profile, businessType: String
    let phoneNumberCode, mobileNoCode, phoneNumber: String
    let mobileNo, email, altEmail, password: String
    let wName, wAddress, wPhone, platform: String
    let adminRights: Int
    //let approvalWorkflowSettings: String
    let isDeleted, status: Int
    let statusName: String
    //  let onBoardingStatus: Int
    //let onBoardingStatusName: String
    //let buyerSupplier, ownerBuyerNo: String
    // let emailNotification, phoneNotification: Int
    let createdBy, updatedBy, createdByID, updatedByID: String
    let updatedAt, createdAt: String
    //   let defaultSetting: DefaultSetting
    //  let onBoardingAssignedTo, onBoardingAssignedToName, onBoardingDate: String
    let deliverySetting: DeliverySetting?
    let ratings: Double
    let isFavorite, noWarehouse: ValueWrapper
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        //  case isOffline = "is_offline"
        case companyName = "company_name"
        case companyRegistrationNo = "company_registration_no"
        case address, country, city, pobox, firstname, middlename, lastname, profile
        case businessType = "business_type"
        //case businessTypeOther = "business_type_other"
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
        //  case approvalWorkflowSettings = "approval_workflow_settings"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        //  case onBoardingStatus = "on_boarding_status"
        // case onBoardingStatusName = "on_boarding_status_name"
        //  case buyerSupplier = "buyer_supplier"
        // case ownerBuyerNo = "owner_buyer_no"
        // case emailNotification = "email_notification"
        // case phoneNotification = "phone_notification"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdByID = "created_by_id"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        //  case defaultSetting = "default_setting"
        //case onBoardingAssignedTo = "on_boarding_assigned_to"
        // case onBoardingAssignedToName = "on_boarding_assigned_to_name"
        // case onBoardingDate = "on_boarding_date"
        case deliverySetting = "delivery_setting"
        case ratings, isFavorite
    }
}
// MARK :- CategoryInfo
struct CategoryInfo: Codable {
    let id, categoryName , categoryImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case categoryName = "category_name"
        case categoryImage = "category_image"
    }
}




enum Default: Codable {
    case bool(Bool)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Default.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Default"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}


enum ValueWrapper: Codable {
    case stringValue(String)
    case intValue(Int)
    case doubleValue(Double)
    case boolValue(Bool)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .stringValue(value)
            print(self)
            return
        }
        if let value = try? container.decode(Bool.self) {
            self = .boolValue(value)
            return
        }
        if let value = try? container.decode(Double.self) {
            self = .doubleValue(value)
            return
        }
        if let value = try? container.decode(Int.self) {
            self = .intValue(value)
            return
        }
        
        throw DecodingError.typeMismatch(ValueWrapper.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValueWrapper"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .stringValue(value):
            try container.encode(value)
        case let .boolValue(value):
            try container.encode(value)
        case let .intValue(value):
            try container.encode(value)
        case let .doubleValue(value):
            try container.encode(value)
        }
    }
    
    var rawValue: String {
        var result: String
        switch self {
        case let .stringValue(value):
            result = value
        case let .boolValue(value):
            result = String(value)
        case let .intValue(value):
            result = String(value)
        case let .doubleValue(value):
            result = String(value)
        }
        return result
    }
    
    var intValue: Int? {
        var result: Int?
        switch self {
        case let .stringValue(value):
            result = Int(value)
        case let .intValue(value):
            result = value
        case let .boolValue(value):
            result = value ? 1 : 0
        case let .doubleValue(value):
            result = Int(value)
        }
        return result
    }
    
    var boolValue: Bool? {
        var result: Bool?
        switch self {
        case let .stringValue(value):
            result = Bool(value)
        case let .boolValue(value):
            result = value
        case let .intValue(value):
            result = Bool(truncating: value as NSNumber)
        case let .doubleValue(value):
            result = Bool(truncating: value as NSNumber)
        }
        return result
    }
}
enum MetadataType: Codable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .int(container.decode(Int.self))
        } catch DecodingError.typeMismatch {
            do {
                self = try .string(container.decode(String.self))
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(MetadataType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}


