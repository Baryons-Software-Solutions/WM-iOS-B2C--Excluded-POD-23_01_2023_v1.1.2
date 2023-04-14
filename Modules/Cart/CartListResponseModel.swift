//
//  CartListResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 23/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

import Foundation

// MARK: - CartListResponseModel
struct CartListResponseModel: Codable {
    let success: String
    let data: CartListResponse?
    let message: String
}

// MARK: - DataClass
struct CartListResponse: Codable {
    let totalProductCount: ValueWrapper?
    let consolidatedPayableAmount: Double
    let cart: [Cart]?
    
    enum CodingKeys: String, CodingKey {
        case totalProductCount = "total_product_count"
        case consolidatedPayableAmount = "consolidated_payable_amount"
        case cart
    }
}

// MARK: - Cart
struct Cart: Codable {
    let id, userID, buyerID: String
    let buyerCompanyRegistrationNo, buyerCompanyName: String?
    let status: Int
    let supplierID/*, outletID*/: String
    let notes: ValueWrapper?
    let supplierInfo: SupplierInfo
    //  let outletInfo: OutletInfo
    let vat: Vat?
    let productsInfo: [ProductsInfo]?
    let totalNetAmount, vatAmount: ValueWrapper?
    let deliveryFee: ValueWrapper?
    let totalPayableAmount: ValueWrapper?
    let deliveryRequested: DeliveryRequested?
    let minOrder/*, eligibleForProcess*/: Int
    let eligiblityMessage: ValueWrapper?
    let deliveryAddress, billingAddress, createdBy, createdByID: String
    let updatedBy, updatedByID, updatedAt, createdAt: String
    let deliverySchedule: [DeliverySchedule]?
    let specialProductNote: ValueWrapper?
    let minOrderValue: String
    let rejectMinOrderValue: String
    //let nextDeliveryDate: String //Baryons-Surendra added on 25/01/22
    enum CodingKeys: String, CodingKey {
        case minOrderValue = "minimum_order_value"
        case rejectMinOrderValue = "reject_order_min_val"
        case id = "_id"
        case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case buyerCompanyRegistrationNo = "buyer_company_registration_no"
        case status
        case supplierID = "supplier_id"
        //   case outletID = "outlet_id"
        case notes
        case deliveryRequested = "delivery_requested"
        case supplierInfo = "supplier_info"
        //    case outletInfo = "outlet_info"
        case vat
        case productsInfo = "products_info"
        case totalNetAmount = "total_net_amount"
        case vatAmount = "vat_amount"
        case deliveryFee = "delivery_fee"
        case totalPayableAmount = "total_payable_amount"
        case minOrder = "min_order"
        //  case eligibleForProcess = "eligible_for_process"
        case eligiblityMessage = "eligiblity_message"
        case deliveryAddress = "delivery_address"
        case billingAddress = "billing_address"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case deliverySchedule = "delivery_schedule"
        case specialProductNote = "special_product_note"
        //case nextDeliveryDate = "Next_Deliver_Date" //Baryons-Surendra added on 25/01/22
    }
}

// MARK: - OutletInfo
struct OutletInfo: Codable {
    let name, logo, phoneNumber, mobileNumber: String
    let countryCode, email: String
    
    enum CodingKeys: String, CodingKey {
        case name,logo
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
        case countryCode = "country_code"
        case email
    }
}


// MARK: - ProductsInfo
struct ProductsInfo: Codable {
    let id, priceRangeID, productName: String
    let brand, option, productCode: ValueWrapper?
    let minOrderQty: ValueWrapper?
    let uom, pricePerUnit: ValueWrapper?
    let uomNumber: ValueWrapper?
    let displaySkuName: ValueWrapper?
    let discountPercentage: ValueWrapper?
    let qty, rQty, costPrice, netPrice, discountAmount: ValueWrapper?
    let productImage: String
    let notes: ValueWrapper?
    let type: ValueWrapper?
    
    enum CodingKeys: String, CodingKey {
        case id
        case priceRangeID = "price_range_id"
        case productCode = "product_code"
        case productName = "product_name"
        case brand, option
        case minOrderQty = "min_order_qty"
        case uom
        case uomNumber = "uom_number"
        case displaySkuName = "display_sku_name"
        case pricePerUnit = "price_per_unit"
        case discountPercentage = "discount_percentage"
        case discountAmount = "discount_amount"
        case qty
        case rQty = "r_qty"
        case costPrice = "cost_price"
        case netPrice = "net_price"
        case productImage = "product_image"
        case notes, type
    }
}

// MARK: - SupplierInfo

struct SupplierInfo: Codable {
    let companyName, companyRegistrationNo, address: ValueWrapper?
    let country, city, pobox, firstname: ValueWrapper?
    let middlename, lastname, profile, phoneNumberCode: ValueWrapper?
    let mobileNoCode, phoneNumber, mobileNo, email: ValueWrapper?
    let createdBy: ValueWrapper?
    let id,supplierName, supplierAddress, supplierProfile, supplierProfileID: ValueWrapper?
    
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
        case supplierName = "supplier_name"
        case supplierAddress = "supplier_address"
        case supplierProfile = "supplier_profile"
        case supplierProfileID = "profile_id"
    }
}
// MARK: - Vat
struct Vat: Codable {
    let applicable: Bool
    let percentage: ValueWrapper?
}
