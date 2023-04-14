//
//  CategoryListModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 19/03/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//

import Foundation

// MARK: - CategoryListModel
struct CategoryListModel: Codable {
    let success: String
    let data: [CategoryList]
    let totalCount: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case totalCount = "total_count"
        case message
    }
}

// MARK: - Datum
struct CategoryList: Codable {
    let id, categoryCode, categoryName: String
    let isDeleted, status: Int
    let statusName: String
    let createdBy, updatedBy: String
    let createdByID, updatedByID: String
    let updatedAt, createdAt: String
    let categoryImage: String?
    let categoryDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case categoryCode = "category_code"
        case categoryName = "category_name"
        case isDeleted = "is_deleted"
        case status
        case statusName = "status_name"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdByID = "created_by_id"
        case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case categoryImage = "category_image"
        case categoryDescription = "category_description"
    }
}

