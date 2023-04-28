//
//  RegisterResponseModel.swift
//  Watermelon-iOS_GIT
//
//  Created by Mac on 28/08/20.\
//  Updated by Avinash on 11/03/23.
//  Copyright © 2020 Mac. All rights reserved.
//
// This RegisterResponseModel class used in RegisterViewController.
import Foundation
// MARK: - RegisterResponseModel
struct RegisterResponseModel: Codable {
    let success: String
//    let data: Any  //[JSONAny]?
    let message: String
}

