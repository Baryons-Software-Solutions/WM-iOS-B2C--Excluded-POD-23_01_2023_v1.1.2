//
//  PlacedOrderResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 30/11/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This PlacedOrderResponseModel class used in FavouriteViewController,MyOrderViewController,InvoicesVC.
import Foundation


//MARK: - ProviderProfileResponseModel


// MARK: - PlacedOrderResponseModel
struct PlacedOrderResponseModel: Codable {
    let success: String
    let data: PlacedOrderResponse?
    let message: String
}



// MARK: - DataClass
struct PlacedOrderResponse: Codable {
    let totalCount: Int
    let orders: [Order]
    let statusDropdown: [StatusDropdown]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case orders
        case statusDropdown = "status_dropdown"
    }
}

// MARK: - Profile



// MARK: - Order
struct Order: Codable {
    let id, uniqueName, buyerID: String
    let buyerCompanyName, buyerCompanyRegistrationNo: String?
    let status: ValueWrapper?
    let supplierID/*, outletID*/: String
    let notes: ValueWrapper?
    let supplierInfo: SupplierInfo
    let outletInfo: OutletInfo
    let vat: Vat
    let productsInfo: [ProductsInfo]
    let totalNetAmount, vatAmount: ValueWrapper
    let deliveryFee: ValueWrapper
    let totalPayableAmount: ValueWrapper
    let minOrder: Int
    let paidStatus:Int?
    let deliveryAddress, billingAddress /*draftOrderID*/: String
    let createdBy: ValueWrapper
    let createdByID: String
    let updatedBy: ValueWrapper
    let updatedByID: String
    let logs: [Log]
    let updatedAt, createdAt: String
    let orderDateTime : String
    let statusName: ValueWrapper
    let number: Int
    let deliveryRequested: DeliveryRequested
    let dueDate : String?
    let pdf: String
    let invoiceStatus: InvoiceStatus?
    //   let buyerAddress : BuyerAddress?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        //  case buyerAddress = "buyer_address"
        case uniqueName = "unique_name"
        // case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case buyerCompanyRegistrationNo = "buyer_company_registration_no"
        case status
        case supplierID = "supplier_id"
        //  case outletID = "outlet_id"
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
        //     case draftOrderID = "draft_order_id"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case orderDateTime = "Order_date_time"
        case updatedByID = "updated_by_id"
        case logs
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case statusName = "status_name"
        case number
        case deliveryRequested = "delivery_requested"
        case pdf
        //  case pdfName = "pdf_name"
        case paidStatus = "paid_status"
        case invoiceStatus = "invoice_status"
        case dueDate = "due_date"
    }
}

// MARK: - BuyerAddress
struct BuyerAddress: Codable {
    let id, address, country, city: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case address, country, city
    }
}



// MARK: - DeliveryRequested
struct DeliveryRequested: Codable {
    let opted: Bool
    let deliveryDate: ValueWrapper?
    let isDeliverable: Bool
    let message: ValueWrapper?
    
    enum CodingKeys: String, CodingKey {
        case opted
        case deliveryDate = "delivery_date"
        case isDeliverable = "is_deliverable"
        case message
    }
}

// MARK: - Log
struct Log: Codable {
    let userID: String?
    let userName: ValueWrapper?
    //  let userType: Int?
    let notes: ValueWrapper?
    let ownerID, ownerName, ownerCompanyRegistrationNo, dateTime: String?
    let status: ValueWrapper?
    let statusName: ValueWrapper?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userName = "user_name"
        //  case userType = "user_type"
        case notes
        case ownerID = "owner_id"
        case ownerName = "owner_name"
        case ownerCompanyRegistrationNo = "owner_company_registration_no"
        case dateTime = "date_time"
        case status
        case statusName = "status_name"
    }
}
