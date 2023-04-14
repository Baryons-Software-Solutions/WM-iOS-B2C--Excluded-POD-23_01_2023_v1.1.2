//
//  UpdateProductCartModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 26/11/20.
//  Updated by Avinash on 11/03/23.

//

import Foundation
// MARK: - UpdateProductCartModel
struct UpdateProductCartModel: Codable {
    let success: String
    let data: UpdateProductCart?
    let message: String
}

// MARK: - DataClass
struct UpdateProductCart: Codable {
    let consolidatedPayableAmount: Double
    let updatedCart: UpdatedCart?
    
    enum CodingKeys: String, CodingKey {
        case consolidatedPayableAmount = "consolidated_payable_amount"
        case updatedCart = "updated_cart"
    }
}

// MARK: - UpdatedCart
struct UpdatedCart: Codable {
    let id, userID, buyerID: String
    let buyerCompanyName, buyerCompanyRegistrationNo: String?
    let status: Int
    let supplierID/*, outletID*/: String
    let notes: ValueWrapper?
    let supplierInfo: SupplierInfo
    let outletInfo: OutletInfo
    let vat: Vat
    let productsInfo: [ProductsInfo]
    let totalNetAmount: ValueWrapper?
    let vatAmount: ValueWrapper?
    let deliveryFee: ValueWrapper?
    let totalPayableAmount: ValueWrapper?
    let minOrder/*, eligibleForProcess*/: Int
    let eligiblityMessage: ValueWrapper?
    let deliveryAddress, billingAddress, createdBy, createdByID: String
    let updatedBy, updatedByID, updatedAt, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case buyerCompanyRegistrationNo = "buyer_company_registration_no"
        case status
        case supplierID = "supplier_id"
        //   case outletID = "outlet_id"
        case notes
        case supplierInfo = "supplier_info"
        case outletInfo = "outlet_info"
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
    }
}
