//
//  HomeScreenDataModel.swift
//  Watermelon-iOS_GIT
//
//  Created by chittiraju on 12/07/22.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct HomeScreenDataModel: Codable {
    let success: String
    let getCategoryList, getAllCategoryList: [GetCategoryList]
    let supplierOfferSectionList: NList
    //    let exploreitem: Exploreitem
    let getTopProductList: GetTopProductList
    let getRecentList: GetRecentList
    let getWeekelyDealsList: GetWeekelyDealsList
    let getBuyAgainList: NList
    let getoutletLocation: [GetoutletLocation]
    let suppliersGetList, getMyfavouriteList, getTopsuppliersList: [GetMyfavouriteList]
    let message: String
    let mycartCount : Int
    
    enum CodingKeys: String, CodingKey {
        case success, getCategoryList,getAllCategoryList
        case supplierOfferSectionList = "SupplierOfferSectionList"
        case  getTopProductList, getRecentList, getWeekelyDealsList, getBuyAgainList, getoutletLocation, suppliersGetList, getMyfavouriteList, message, getTopsuppliersList
        case mycartCount = "mycart_Count"
        //        case exploreitem
    }
}
struct PricingRangeHome: Codable {
    let id: String
    let pricingRangeDefault: Bool
    let priceunit: String
    let pricemoq: Int
    let ref, promo: Double
    let skuStatus: Int
    let isuom: Bool
    let displaySkuName: String
    let listPrice, originalPrice: Double
    //   let quantityAlreadyInCart: Int
    let cartID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case pricingRangeDefault = "default"
        case priceunit, pricemoq, ref, promo
        case skuStatus = "sku_status"
        case isuom
        case displaySkuName = "display_sku_name"
        case listPrice = "list_price"
        case originalPrice = "original_price"
        //     case quantityAlreadyInCart = "quantity_already_in_cart"
        case cartID = "cart_id"
    }
}

// MARK: - Exploreitem
struct Exploreitem: Codable {
    let exploreHeader: Header
    let exploreList: [List]
}

// MARK: - Header
struct Header: Codable {
    let mainTitle, seeAll: String
    
    enum CodingKeys: String, CodingKey {
        case mainTitle = "main_title"
        case seeAll = "see_all"
    }
}
// MARK: - List
struct List: Codable {
    let productImage: String
    let offerPercent: String?
    let /*supplier,*/ productName, productCode: String
    let supplierID: String
    let id, quantity/*, avgRating*/: String
    let pricingRange: [PricingRangeHome]
    let supplierInfo: [GetMyfavouriteList]
    //   let wishlist: String?
    
    enum CodingKeys: String, CodingKey {
        case productImage = "product_image"
        case offerPercent = "offer_percent"
        //   case supplier
        case productName = "product_name"
        case productCode = "product_code"
        case supplierID = "supplier_id"
        case id = "_id"
        case quantity
        //  case avgRating = "avg_rating"
        case pricingRange = "pricing_range"
        case supplierInfo = "supplier_info"
        //    case wishlist
    }
}

// MARK: - GetMyfavouriteList
struct GetMyfavouriteList: Codable {
    let id, companyName, companyRegistrationNo, address: String
    let country: String
    let city: String
    let pobox, firstname, middlename, lastname: String
    let profile: String
    let phoneNumberCode, mobileNoCode: String
    let phoneNumber, mobileNo, email: String
    let createdBy: String
 //   let defaultSetting: DefaultSetting?
    let isOffline: Bool?
    let status /*ratings*/: Int?
    let isFavorite: Bool?
    let license: String?
    let isfavouriteValue, productCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case companyName = "company_name"
        case companyRegistrationNo = "company_registration_no"
        case address, country, city, pobox, firstname, middlename, lastname, profile
        case phoneNumberCode = "phone_number_code"
        case mobileNoCode = "mobile_no_code"
        case phoneNumber = "phone_number"
        case mobileNo = "mobile_no"
        case email
        case createdBy = "created_by"
      //  case defaultSetting = "default_setting"
        case isOffline = "is_offline"
        case status, /*ratings,*/ isFavorite, license, isfavouriteValue
        case productCount = "product_count"
    }
}




// MARK: - NList
struct NList: Codable {
    //   let headers: Headers
    //   let original: Original
    let exception: JSONNull?
}

// MARK: - Headers
struct Headers: Codable {
}

// MARK: - Original
struct Original: Codable {
    let success: String
    let data, response: [JSONAny]
    let message: String
}

// MARK: - GetCategoryList
struct GetCategoryList: Codable {
    let categoryProfile, categoryName, categoryID: String
    
    enum CodingKeys: String, CodingKey {
        case categoryProfile = "category_profile"
        case categoryName = "category_name"
        case categoryID = "category_id"
    }
}

// MARK: - GetRecentList
struct GetRecentList: Codable {
    //    let recentHeader: Header
    //   let recentLists: [List]
}

// MARK: - GetTopProductList
struct GetTopProductList: Codable {
    let topProheader: Header
    let topProLists: [List]
}
// MARK: - GetWeekelyDealsList
struct GetWeekelyDealsList: Codable {
    let weekDealsBanner: WeekDealsBanner
    let weekDealsFooter: WeekDealsFooter
    let weekDealsList: [WeekDealsList]
}

// MARK: - WeekDealsBanner
struct WeekDealsBanner: Codable {
    let bannerTitle, bannerImage: String
    
    enum CodingKeys: String, CodingKey {
        case bannerTitle = "banner_title"
        case bannerImage = "banner_image"
    }
}

// MARK: - WeekDealsFooter
struct WeekDealsFooter: Codable {
    let seeAll: String
    
    enum CodingKeys: String, CodingKey {
        case seeAll = "see_all"
    }
}

// MARK: - WeekDealsList
struct WeekDealsList: Codable {
    let productImage, offerPercent, category, title: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case productImage = "product_image"
        case offerPercent = "offer_percent"
        case category, title, link
    }
}

// MARK: - GetoutletLocation
struct GetoutletLocation: Codable {
    let id, outletName, address, phoneNumber: String
    let mobileNumber: String
    let mobileCountryCode, countryCode: String
    let email, buyerID, outletUser, outletLogo: String
    let timeZone: String
    let tags: String
    let country: String
    let city: String
    let area: String
    let isDeleted, status: Int
    let billingAddress: String
    let billingCountry: String
    let billingCity: String
    let billingArea, createdBy, createdByID, updatedBy: String
    let updatedByID, updatedAt, createdAt: String
    let userIDS: [String?]
    let otherFeatures, statusName, typeOfBusiness, typeOfCuisine: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case outletName = "outlet_name"
        case address
        case phoneNumber = "phone_number"
        case mobileNumber = "mobile_number"
        case mobileCountryCode = "mobile_country_code"
        case countryCode = "country_code"
        case email
        case buyerID = "buyer_id"
        case outletUser = "outlet_user"
        case outletLogo = "outlet_logo"
        case timeZone = "time_zone"
        case tags, country, city, area
        case isDeleted = "is_deleted"
        case status
        case billingAddress = "billing_address"
        case billingCountry = "billing_country"
        case billingCity = "billing_city"
        case billingArea = "billing_area"
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case userIDS = "user_ids"
        case otherFeatures = "other_features"
        case statusName = "status_name"
        case typeOfBusiness = "type_of_business"
        case typeOfCuisine = "type_of_cuisine"
    }
}


