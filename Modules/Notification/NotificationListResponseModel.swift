//
//  NotificationListResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 18/01/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//
// This NotificationListResponseModel class used in NotificationVC.
import Foundation

// MARK: - NotificationListResponseModel
struct NotificationListResponseModel: Codable {
    let success: String
    let data: NotificationListResponse?
    let message: String
}

// MARK: - DataClass
struct NotificationListResponse: Codable {
    let totalCount, filteredCount: Int
    let notifications: [NotificationResponse]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case filteredCount = "filtered_count"
        case notifications
    }
}

// MARK: - Notification
struct NotificationResponse: Codable {
    let id: String
    // let user: CreatedByID
    let title, body: String
    // let module: Module
    //let event: Event
    let isRead, isDeleted: Int
    // let createdBy: AtedBy
    //let createdByID: CreatedByID
    // let updatedBy: AtedBy
    //let updatedByID: CreatedByID
    let updatedAt, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case  title, body
        case isRead = "is_read"
        case isDeleted = "is_deleted"
        //case createdBy = "created_by"
        //  case createdByID = "created_by_id"
        //case updatedBy = "updated_by"
        // case updatedByID = "updated_by_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
enum Event: String, Codable {
    case created = "Created"
}

enum Module: String, Codable {
    case order = "Order"
}

