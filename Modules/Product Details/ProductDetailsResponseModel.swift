
//  Updated by Avinash on 11/03/23.
// This ProductDetailsResponseModel class used in ProductImageViewController,ProductDetailsVC.
import Foundation
struct ProductDetailsResponseModel : Codable {
    let success : String?
    var data : ProductData?
    let message : String?
    let similarProducts: [SimilarProduct]
    
    enum CodingKeys: String, CodingKey {
        case similarProducts = "similarProducts"
        case success = "success"
        case data = "data"
        case message = "message"
    }
}

// MARK: - SimilarProduct
struct SimilarProduct: Codable {
    let id, productImage, supplierProductCode: String
    let number: Int
    let productCode, productName, brand, categoryID: String
    let categoryName, subcategoryID, subcategoryName, baseUom: String
    let criticalLevel: Int
    let criticalLevelAlert: String
    let orderingOption: [SimilarProductOrderingOption]
    let shelfLife: Int
    let shelfDaymonth, countryOfOrigin, upcEanNo: String
    let certification: [String]
    let inMarketplace: Int
    let displayPrice: Bool
    let skuName: String
    let leadTime: Int
    let leadDaymonth: String
    let pricingRange: [SimilarProductPricingRange]
    let rfq, userTypeID: String
    let isDeleted, popularity, status: Int
    let statusName, createdBy, createdByID, updatedBy: String
    let updatedByID, updatedAt, createdAt: String
    
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
        case orderingOption = "ordering_option"
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
        case popularity, status
        case statusName = "status_name"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - SimilarProductOrderingOption
struct SimilarProductOrderingOption: Codable {
    let orderunit: String
    let equalsto: Int
}

// MARK: - SimilarProductPricingRange
struct SimilarProductPricingRange: Codable {
    let id: String
    let pricingRangeDefault: Bool
    let priceunit: String
    let pricemoq: Int
    let ref, promo: Double
    let skuStatus: Int
    let isuom: Bool
    let displaySkuName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case pricingRangeDefault = "default"
        case priceunit, pricemoq, ref, promo
        case skuStatus = "sku_status"
        case isuom
        case displaySkuName = "display_sku_name"
    }
}


