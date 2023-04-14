//
//  ProcessCartResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Apple on 02/12/20.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

import Foundation
import SwiftyJSON

// MARK: - ProcessCartResponseModel
struct ProcessCartResponseModel: Codable {
    let success: String
    let data: [JSONAny]
    let message: String
    let redirectCode: RedirectCode?
    
    enum CodingKeys: String, CodingKey {
        case success, data, message
        case redirectCode = "redirect_code"
    }
}

// MARK: - RedirectCode
struct RedirectCode: Codable {
    let status: Int
    let module: String
}
