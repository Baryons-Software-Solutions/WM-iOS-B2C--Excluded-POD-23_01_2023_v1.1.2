//
//  PlacedOrderViewResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 30/11/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

import Foundation
// MARK: - PlacedOrderViewResponseModel
struct PlacedOrderViewResponseModel: Codable {
    let success: String
    let data: PlacedOrderViewResponse?
    let message: String
}

// MARK: - DataClass
struct PlacedOrderViewResponse: Codable {
    let order: Order?
    let invoiceStatus: InvoiceStatus
    enum CodingKeys: String, CodingKey {
        case order
        case invoiceStatus = "invoice_status"
    }
}
// MARK: - InvoiceStatus
struct InvoiceStatus: Codable {
    let created: ValueWrapper?
    let createdMessage: ValueWrapper?
    let status: ValueWrapper?
    let statusName, invoiceID, invoiceNumber: ValueWrapper?
    let invoiceLink: ValueWrapper?
    let displayGenerateInvoiceButton: ValueWrapper?
    
    enum CodingKeys: String, CodingKey {
        case created
        case createdMessage = "created_message"
        case status
        case statusName = "status_name"
        case invoiceID = "invoice_id"
        case invoiceNumber = "invoice_number"
        case invoiceLink = "invoice_link"
        case displayGenerateInvoiceButton = "display_generate_invoice_button"
    }
}
