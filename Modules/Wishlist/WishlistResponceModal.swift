
//  WishlistResponceModal.swift
//  Watermelon-iOS_GIT
//
//  Created by admin on 23/08/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
import Foundation

struct WishlistResponceModal: Codable {
    let success: String
    let data: [WishlistResponce]?
    let message: String
}
struct WishlistResponce: Codable {
    
    let id, userID,supplierCompanyName,productName,supplierName,statusName,createdBy: String?
    let productImage: String?
    let supplierID:String?
    let status: Int?
    let createdByID,updatedBy,updatedByID,updatedAt,createdAt : String?
    let productDetail: ProductDetail
    let productCode : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productCode = "product_code"
        case userID = "user_id"
        case productImage = "product_image"
        case productName = "product_name"
        case supplierID = "supplier_id"
        case supplierCompanyName = "supplier_company_name"
        case supplierName = "supplier_name"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case productDetail = "product_detail"
        
    }
}
struct ProductDetail: Codable {
    let id, productImage, supplierProductCode: String
    let number: Int
    let productCode, productName, brand, categoryID: String
    let categoryName, subcategoryID, subcategoryName, baseUom: String
    let criticalLevel: Int
    let criticalLevelAlert: String
    //  let orderingOption: [OrderingOption]
    let shelfLife: Int
    let shelfDaymonth, countryOfOrigin, upcEanNo: String
    let certification: [JSONAny]
    let inMarketplace: Int
    let displayPrice: Bool
    let skuName: String
    let leadTime: Int
    let leadDaymonth: String
    let pricingRange: [PricingRange]
    let rfq, userTypeID: String
    let isDeleted, status: Int
    let statusName, createdBy, createdByID, updatedBy: String
    let updatedByID, updatedAt, createdAt: String
    let popularity/* avgRating*/: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productImage = "product_image"
        case supplierProductCode = "supplier_product_code"
        case number
        case productCode = "product_code"
        case productName = "product_name"
        case brand
        case categoryID = "category_id"
        case categoryName = "category_name"
        case subcategoryID = "subcategory_id"
        case subcategoryName = "subcategory_name"
        case baseUom = "base_uom"
        case criticalLevel = "critical_level"
        case criticalLevelAlert = "critical_level_alert"
        //   case orderingOption = "ordering_option"
        case shelfLife = "shelf_life"
        case shelfDaymonth = "shelf_daymonth"
        case countryOfOrigin = "country_of_origin"
        case upcEanNo = "upc_ean_no"
        case certification
        case inMarketplace = "in_marketplace"
        case displayPrice = "display_price"
        case skuName = "sku_name"
        case leadTime = "lead_time"
        case leadDaymonth = "lead_daymonth"
        case pricingRange = "pricing_range"
        case rfq
        case userTypeID = "user_type_id"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case popularity
        // case avgRating = "avg_rating"
    }
}

