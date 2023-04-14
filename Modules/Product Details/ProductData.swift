/* 
 Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar
 
 */
//  Updated by Avinash on 11/03/23.
import Foundation
struct ProductData: Codable {
    var product : Productz?
    let supplierInfo : SupplierInfoz?
    let wishlist : Wishlistz?
    //	let review : [String]?
    //	let totalReview : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case product = "product"
        case supplierInfo = "supplierInfo"
        case wishlist = "wishlist"
        //		case review = "review"
        //		case totalReview = "totalReview"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product = try values.decodeIfPresent(Productz.self, forKey: .product)
        supplierInfo = try values.decodeIfPresent(SupplierInfoz.self, forKey: .supplierInfo)
        wishlist = try values.decodeIfPresent(Wishlistz.self, forKey: .wishlist)
        //		review = try values.decodeIfPresent([String].self, forKey: .review)
        //		totalReview = try values.decodeIfPresent(Int.self, forKey: .totalReview)
    }
    
}
struct Wishlistz: Codable {
    let _id : String?
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }
}
