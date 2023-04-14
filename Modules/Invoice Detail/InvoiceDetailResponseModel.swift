//
//  InvoiceDetailResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 09/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This InvoiceDetailResponseModel class used in InvoiceDetailsVC.
import Foundation
// MARK: - InvoiceDetailResponseModel
struct InvoiceDetailResponseModel: Codable {
    let success: String
    let data: InvoiceDetailResponse?
    let message: String
}

// MARK: - DataClass
struct InvoiceDetailResponse: Codable {
    let invoice: Invoice?
    let paymentHistory: [PaymentHistory]?

    enum CodingKeys: String, CodingKey {
        case invoice
        case paymentHistory = "payment_history"
    }
}
// MARK: - PaymentHistory
struct PaymentHistory: Codable {
    let id: String
    let transactionNumber: Int
    let uniqueName, date: String
    let transactionId, amount: ValueWrapper?
    let type, remarks, invoiceID, invoiceUniqueName: String
    let userID, buyerID: String
    let buyerCompanyName, buyerCompanyRegistrationNo: String?
    let orderID, orderUniqueName, supplierID: String
    let supplierInfo: SupplierInfo
    let outletID: String
    let outletInfo: OutletInfo
    let isReceived: Int
    let createdBy, createdByID, updatedBy, updatedByID: String
    let updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case transactionId = "transaction_id"
        case transactionNumber = "transaction_number"
        case uniqueName = "unique_name"
        case date, amount, type, remarks
        case invoiceID = "invoice_id"
        case invoiceUniqueName = "invoice_unique_name"
        case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case buyerCompanyRegistrationNo = "buyer_company_registration_no"
        case orderID = "order_id"
        case orderUniqueName = "order_unique_name"
        case supplierID = "supplier_id"
        case supplierInfo = "supplier_info"
        case outletID = "outlet_id"
        case outletInfo = "outlet_info"
        case isReceived = "is_received"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
// MARK: - Payment
struct Payment: Codable {
    let id: String
    let transactionNumber: Int
    let uniqueName, date: String
    let transactionId,amount: ValueWrapper?
    let type, remarks, invoiceID, invoiceUniqueName: String
    let userID, buyerID: String
    let buyerCompanyName, buyerCompanyRegistrationNo: String?
    let orderID, orderUniqueName, supplierID: String
    let supplierInfo: SupplierInfo?
    let outletID: String
    let outletInfo: OutletInfo?
    let isReceived: Int
    let createdBy, createdByID, updatedBy, updatedByID: String
    let updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case transactionId = "transaction_id"
        case transactionNumber = "transaction_number"
        case uniqueName = "unique_name"
        case date, amount, type, remarks
        case invoiceID = "invoice_id"
        case invoiceUniqueName = "invoice_unique_name"
        case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case buyerCompanyRegistrationNo = "buyer_company_registration_no"
        case orderID = "order_id"
        case orderUniqueName = "order_unique_name"
        case supplierID = "supplier_id"
        case supplierInfo = "supplier_info"
        case outletID = "outlet_id"
        case outletInfo = "outlet_info"
        case isReceived = "is_received"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
