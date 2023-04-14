//
//  ConfigurationsModal.swift
//  Watermelon-iOS_GIT
//
//  Created by Nirzar Gandhi on 12/04/21.
//  Updated by Avinash on 11/03/23.
//  Copyright © 2021 Mac. All rights reserved.
//

struct ConfigurationsModal : Codable {
    let success : String?
    let data : ConfigurationsData?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case data = "data"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(String.self, forKey: .success)
        data = try values.decodeIfPresent(ConfigurationsData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct ConfigurationsData : Codable {
    let configurations : [Configurations]?
    
    enum CodingKeys: String, CodingKey {
        
        case configurations = "configurations"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        configurations = try values.decodeIfPresent([Configurations].self, forKey: .configurations)
    }
}

struct Configurations : Codable {
    let _id : String?
    let code : String?
    let value : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case code = "code"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}
