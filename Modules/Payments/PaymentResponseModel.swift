//
//  PaymentResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 14/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This PaymentResponseModel class used in InvoiceVC.
import Foundation
// MARK: - PaymentResponseModel
struct PaymentResponseModel: Codable {
    let success: String
    let data: PaymentResponse?
    let message: String
}

// MARK: - DataClass
struct PaymentResponse: Codable {
    let totalCount: Int
    let payments: [Payment]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case payments
    }
}
