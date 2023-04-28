//
//  InvoiceListResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 07/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This InvoiceListResponseModel class used in InvoiceVC.
import Foundation
// MARK: - InvoiceListResponseModel
struct InvoiceListResponseModel: Codable {
    let success: String
    let data: InvoiceListResponse?
    let message: String
}

// MARK: - DataClass
struct InvoiceListResponse: Codable {
    let totalCount: Int
    let invoices: [Invoice]
    let statusDropdown: [StatusDropdown]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case invoices
        case statusDropdown = "status_dropdown"
    }
}

// MARK: - Invoice
struct Invoice: Codable {
    
    let id: String
    let number: Int
    let uniqueName, userID, buyerID: String
    let buyerCompanyName, buyerCompanyRegistrationNo: String?
    let status: ValueWrapper?
    let supplierID, outletID: String
    let notes: ValueWrapper?
    let supplierInfo: SupplierInfo
    let outletInfo: OutletInfo
    let vat: Vat
    let productsInfo: [ProductsInfo]
    let totalNetAmount, vatAmount, deliveryFee, totalPayableAmount: ValueWrapper?
    let minOrder: Int
    let deliveryAddress, billingAddress: String
    let deliveryRequested: DeliveryRequested
    let orderID , orderUniqueName, createdBy, createdByID: String
    let updatedBy, updatedByID, updatedAt, createdAt: String
    let link: String
    //   let pdfName: String
    let logs: [Log]?
    let payments: [Payment]?
    let receivedAmount: ValueWrapper?
    let pendingAmount: ValueWrapper?
    let statusName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case number
        case uniqueName = "unique_name"
        case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case buyerCompanyRegistrationNo = "buyer_company_registration_no"
        case status
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
        case deliveryAddress = "delivery_address"
        case billingAddress = "billing_address"
        case deliveryRequested = "delivery_requested"
        case orderID = "order_id"
        case orderUniqueName = "order_unique_name"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case link
        //case pdfName = "pdf_name"
        case logs, payments
        case receivedAmount = "received_amount"
        case pendingAmount = "pending_amount"
        case statusName = "status_name"
    }
    
}

