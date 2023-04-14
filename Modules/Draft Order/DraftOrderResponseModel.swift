//
//  DraftOrderResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 27/11/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

import Foundation
// MARK: - DraftOrderResponseModel
struct DraftOrderResponseModel: Codable {
    let success: String
    let data: DraftOrderResponse?
    let message: String
}

// MARK: - DataClass
struct DraftOrderResponse: Codable {
    let totalCount: Int
    let draftOrders: [DraftOrder]
    let statusDropdown: [StatusDropdown]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case draftOrders = "draft_orders"
        case statusDropdown = "status_dropdown"
    }
}
// MARK: - DraftOrder
struct DraftOrder: Codable {
    let id: String
    let number: Int
    let uniqueName, userID, buyerID: String
    let buyerCompanyName, buyerCompanyRegistrationNo: String?
    let approveStatus: Int
    let supplierID, outletID: String
    let notes: ValueWrapper?
    let supplierInfo: SupplierInfo?
    let outletInfo: OutletInfo?
    let vat: Vat
    let productsInfo: [ProductsInfo]
    let totalNetAmount, vatAmount, deliveryFee, totalPayableAmount: ValueWrapper?
    let minOrder: Int
    //, eligibleForOrder: Int
    let deliveryRequested: DeliveryRequested
    let eligiblityMessage: ValueWrapper?
    let deliveryAddress, billingAddress, workflow: String
    // let approvalTierLogs: ValueWrapper?
    let createdBy, createdByID, updatedBy, updatedByID: String
    let updatedAt, createdAt: String
    //let approvedBy: ApprovedBy
    let specialProductNote: ValueWrapper?
    let deliverySchedule: [DeliverySchedule]?
    let approveStatusName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case number
        case uniqueName = "unique_name"
        case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case buyerCompanyRegistrationNo = "buyer_company_registration_no"
        case approveStatus = "approve_status"
        case supplierID = "supplier_id"
        case outletID = "outlet_id"
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
        //case eligibleForOrder = "eligible_for_order"
        case deliveryRequested = "delivery_requested"
        case eligiblityMessage = "eligiblity_message"
        case deliveryAddress = "delivery_address"
        case billingAddress = "billing_address"
        case workflow
        //case approvalTierLogs = "approval_tier_logs"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        // case approvedBy = "approved_by"
        case specialProductNote = "special_product_note"
        case deliverySchedule = "delivery_schedule"
        case approveStatusName = "approve_status_name"
    }
}
// MARK: - DeliverySchedule
struct DeliverySchedule: Codable {
    let deliver, days, earlier: ValueWrapper?
}


// MARK: - ApprovedBy
struct ApprovedBy: Codable {
    let userID, userName: String
    let notes: ValueWrapper?
    let dateTime: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        case notes
        case dateTime = "date_time"
    }
}


enum Percentage: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Percentage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Percentage"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - StatusDropdown
struct StatusDropdown: Codable {
    let status: ValueWrapper
    let name: String
    let selected: Int
}
