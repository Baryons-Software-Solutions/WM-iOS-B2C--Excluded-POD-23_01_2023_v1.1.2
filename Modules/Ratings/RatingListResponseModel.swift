
// Updated by Avinash on 11/03/23.
//   let ratingListResponseModel = try? newJSONDecoder().decode(RatingListResponseModel.self, from: jsonData)

// This RatingListResponseModel class used in RatingVC
import Foundation

// MARK: - RatingListResponseModel
struct RatingListResponseModel: Codable {
    let success: String
    let data: RatingListResponse
    let message: String
}

// MARK: - DataClass
struct RatingListResponse: Codable {
    let totalCount, fetchCount: Int
    let ratings: [Rating]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case fetchCount = "fetch_count"
        case ratings
    }
}

// MARK: - Rating
struct Rating: Codable {
    let id, supplierID, supplierCompanyName, userID: String
    let buyerID, buyerCompanyName: String?
    let ratings: Int
    let comments: ValueWrapper?
    let createdBy, createdByID, updatedBy: String
    let updatedByID, updatedAt, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case supplierID = "supplier_id"
        case supplierCompanyName = "supplier_company_name"
        case userID = "user_id"
        case buyerID = "buyer_id"
        case buyerCompanyName = "buyer_company_name"
        case ratings, comments
        case createdBy = "created_by"
        case createdByID = "created_by_id"
        case updatedBy = "updated_by"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
// MARK: - UpdateRatingListResponseModel
struct UpdateRatingListResponseModel: Codable {
    let success: String
    let data: UpdateRatingListResponse
    let message: String
}

// MARK: - DataClass
struct UpdateRatingListResponse: Codable {
    let updatedRatings: Int
    
    enum CodingKeys: String, CodingKey {
        case updatedRatings = "updated_ratings"
    }
}
