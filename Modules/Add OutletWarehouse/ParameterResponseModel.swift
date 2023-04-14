//
//  ParameterResponseModel.swift
//  Watermelon-iOS_GIT

//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.

import Foundation

// MARK: - OutletListResponseModel
struct ParameterResponseModel: Codable {
    let success: String
    let data: [ParameterResponse]?
    let totalCount: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success, data
        case totalCount = "total_count"
        case message
    }
}

// MARK: - Datum
struct ParameterResponse: Codable {
    let id, code, name: String
    let value: String
    let dependentValue: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case code, name, value
        case dependentValue = "dependent_value"
    }
}


enum Value: Codable {
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
        throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
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
