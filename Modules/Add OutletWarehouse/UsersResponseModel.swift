//
//  UsersResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 22/10/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This UsersResponseModel  class used in AddoutletwarehouseVC.
import Foundation
// MARK: - OutletListResponseModel
struct UsersResponseModel: Decodable {
    let success: String
    let data: [UsersResponse]?
    let totalCount: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case totalCount = "total_count"
        case message
    }
}

// MARK: - Datum
struct UsersResponse: Decodable {
    let id, firstname: String
    let middlename: String?
    let lastname, phoneNumber, mobileNoCode: String
    //  let userType: String?
    let userTypeID: String
    let email: String
    let isDeleted /*status*/: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname, middlename, lastname, email
        case phoneNumber = "phone_number"
        case mobileNoCode = "mobile_no_code"
        //      case userType = "user_type"
        case userTypeID = "user_type_id"
        case isDeleted = "is_deleted"
        //     case status
        
    }
}

enum AtedBy: String, Codable {
    case amazonAdmin = "Amazon Admin"
    case havmorRestaurant = "Havmor Restaurant"
    case jioAdmin = "Jio Admin"
    case superAdmin = "Super Admin"
}

enum AtedByID: String, Codable {
    case the5F43793D54B6E8283C3A9354 = "5f43793d54b6e8283c3a9354"
    case the5F802E62F0Db4F44Df752D65 = "5f802e62f0db4f44df752d65"
    case the5F802Ea17Ce53720F4492Bb9 = "5f802ea17ce53720f4492bb9"
    case the5F803D72A22F77219D737195 = "5f803d72a22f77219d737195"
}

enum Designation: String, Codable {
    case adminUser = "Admin User"
    case basicUser = "Basic User"
    case customUser = "Custom User"
    case designation = "Designation"
    case empty = ""
    case jioBasic = "Jio Basic"
    case ok = "ok"
}

enum Notified: String, Codable {
    case empty = ""
    case orderStatusChange = "Order Status Change"
}

enum PermissionUnion: Codable {
    case permissionClass(PermissionClass)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(PermissionClass.self) {
            self = .permissionClass(x)
            return
        }
        throw DecodingError.typeMismatch(PermissionUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PermissionUnion"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .permissionClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - PermissionClass
struct PermissionClass: Codable {
    let acceptOrders, rejectOrders, viewOrders, personalProfileUpdate: Bool?
    let receivePushNotification, viewAnnouncement, viewPromocode, viewTransactions: Bool?
    let deleteDrafts, createPromotions, editPrices, uploadInvoices: Bool?
    let deleteUploadedInvoices, viewInvoices, manageInventory, manageMarketList: Bool?
    let generateEinvoice, approveOrders, editMoqUom, viewWarehouses: Bool?
    let createBuyers, viewUsers, viewMarketList, webPanelAccess: Bool?
    let editInvoices, createCompanies, editCompanies, viewCompanies: Bool?
    let exportInvoices, deleteDigitizedInvoices, digitizedUploadedInvoices, manageAccountingIntegration: Bool?
    let manageEcreditNotes, manageEinvoices, viewReports, manageBuyers: Bool?
    let manageUserRoles, editWarehouses, managePayments, createUsers: Bool?
    let deleteUsers, editUsers, createOrders, editOrders: Bool?
    let createBulkOrders, showPrices, manageStandingOrders, editOrderLimits: Bool?
    let viewOutlets, createOutlets, editDeals, manageSupplier: Bool?
    let editOutlets: Bool?
    let adminLevel: String?
    
    enum CodingKeys: String, CodingKey {
        case acceptOrders = "accept_orders"
        case rejectOrders = "reject_orders"
        case viewOrders = "view_orders"
        case personalProfileUpdate = "personal_profile_update"
        case receivePushNotification = "receive_push_notification"
        case viewAnnouncement = "view_announcement"
        case viewPromocode = "view_promocode"
        case viewTransactions = "view_transactions"
        case deleteDrafts = "delete_drafts"
        case createPromotions = "create_promotions"
        case editPrices = "edit_prices"
        case uploadInvoices = "upload_invoices"
        case deleteUploadedInvoices = "delete_uploaded_invoices"
        case viewInvoices = "view_invoices"
        case manageInventory = "manage_inventory"
        case manageMarketList = "manage_market_list"
        case generateEinvoice = "generate_einvoice"
        case approveOrders = "approve_orders"
        case editMoqUom = "edit_moq_uom"
        case viewWarehouses = "view_warehouses"
        case createBuyers = "create_buyers"
        case viewUsers = "view_users"
        case viewMarketList = "view_market_list"
        case webPanelAccess = "web_panel_access"
        case editInvoices = "edit_invoices"
        case createCompanies = "create_companies"
        case editCompanies = "edit_companies"
        case viewCompanies = "view_companies"
        case exportInvoices = "export_invoices"
        case deleteDigitizedInvoices = "delete_digitized_invoices"
        case digitizedUploadedInvoices = "digitized_uploaded_invoices"
        case manageAccountingIntegration = "manage_accounting_integration"
        case manageEcreditNotes = "manage_ecredit_notes"
        case manageEinvoices = "manage_einvoices"
        case viewReports = "view_reports"
        case manageBuyers = "manage_buyers"
        case manageUserRoles = "manage_user_roles"
        case editWarehouses = "edit_warehouses"
        case managePayments = "manage_payments"
        case createUsers = "create_users"
        case deleteUsers = "delete_users"
        case editUsers = "edit_users"
        case createOrders = "create_orders"
        case editOrders = "edit_orders"
        case createBulkOrders = "create_bulk_orders"
        case showPrices = "show_prices"
        case manageStandingOrders = "manage_standing_orders"
        case editOrderLimits = "edit_order_limits"
        case viewOutlets = "view_outlets"
        case createOutlets = "create_outlets"
        case editDeals = "edit_deals"
        case manageSupplier = "manage_supplier"
        case editOutlets = "edit_outlets"
        case adminLevel = "admin_level"
    }
}

//enum Platform: String, Codable {
//    case android = "Android"
//    case web = "web"
//}

enum RoleID: Codable {
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
        throw DecodingError.typeMismatch(RoleID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RoleID"))
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

enum StatusName: String, Codable {
    case active = "Active"
}

enum TierApproval: String, Codable {
    case empty = ""
    case tier = "tier"
    case value = "value"
}
