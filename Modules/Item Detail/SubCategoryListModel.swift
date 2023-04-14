// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//  Updated by Avinash on 11/03/23.
//   let subCategoryListModel = try? newJSONDecoder().decode(SubCategoryListModel.self, from: jsonData)

import Foundation

// MARK: - SubCategoryListModel
struct SubCategoryListModel: Codable {
    let success: String
    let data: [SubCategoryList]
    let totalCount: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case totalCount = "total_count"
        case message
    }
}

// MARK: - Datum
struct SubCategoryList: Codable {
    let id: String
    let subcategoryImage: String?
    let subcategoryCode, subcategoryName: String
    let subcategoryDescription: String?
    let categoryID: String
    let isDeleted, status: Int
    let statusName: String
    let createdBy, updatedBy: String
    let createdByID, updatedByID: String
    let updatedAt, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case subcategoryImage = "subcategory_image"
        case subcategoryCode = "subcategory_code"
        case subcategoryName = "subcategory_name"
        case subcategoryDescription = "subcategory_description"
        case categoryID = "category_id"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdByID = "created_by_id"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

