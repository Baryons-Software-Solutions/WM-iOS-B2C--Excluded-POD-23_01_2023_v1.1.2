//
//  DeliveryResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 25/03/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//
// This DeliveryResponseModel class used in deliveryVC.
import Foundation
// MARK: - DeliveryResponseModel
struct DeliveryResponseModel: Codable {
    let success: String
    let data: DeliveryResponse
    let message: String
}

// MARK: - DataClass
struct DeliveryResponse: Codable {
    let totalCount, fetchCount: Int
    let upcomingDeliveries: [UpcomingDelivery]
    let statusDropdown: [StatusDropdown]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case fetchCount = "fetch_count"
        case upcomingDeliveries = "upcoming_deliveries"
        case statusDropdown = "status_dropdown"
    }
}


// MARK: - UpcomingDelivery
struct UpcomingDelivery: Codable {
    let id: String
    let number: Int
    let uniqueName, userID, buyerID: String
    let buyerCompanyName, buyerCompanyRegistrationNo: String?
    let status: Int
    let supplierID, outletID: String
    let notes: ValueWrapper?
    let supplierInfo: SupplierInfo?
    let outletInfo: OutletInfo?
    let vat: Vat?
    let productsInfo: [ProductsInfo]?
    let totalCostAmount, totalDiscountAmount, totalNetAmount: Double
    let vatAmount: Double
    //  let deliveryFee: Int
    let totalPayableAmount: Double
    let minOrder: Int
    let deliveryAddress, billingAddress: String
    let deliveryRequested: DeliveryRequested?
    let offlineSupplier: Bool
    let draftOrderID, createdBy, createdByID, updatedBy: String
    let updatedByID: String
    let logs: [Log]
    let updatedAt, createdAt: String
    let pdf: String
    let warehouseID: ValueWrapper?
    
    let pdfName, statusName: String
    let invoiceStatus: InvoiceStatus
    
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
        case totalCostAmount = "total_cost_amount"
        case totalDiscountAmount = "total_discount_amount"
        case totalNetAmount = "total_net_amount"
        case vatAmount = "vat_amount"
        //  case deliveryFee = "delivery_fee"
        case totalPayableAmount = "total_payable_amount"
        case minOrder = "min_order"
        case deliveryAddress = "delivery_address"
        case billingAddress = "billing_address"
        case deliveryRequested = "delivery_requested"
        case offlineSupplier = "offline_supplier"
        case draftOrderID = "draft_order_id"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case logs
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case pdf
        case pdfName = "pdf_name"
        case warehouseID = "warehouse_id"
        case statusName = "status_name"
        case invoiceStatus = "invoice_status"
    }
}
