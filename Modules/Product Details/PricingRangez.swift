
//  Updated by Avinash on 11/03/23.
import Foundation
struct PricingRangez : Codable {
    let product_code : String?
    //	let skuID : String?
    //	let buyer_id : String?
    let supplier_id : String?
    let option : String?
    //	let original_price : Double?
    //	let ismanual_discount : Bool?
    //	let discount_amount : Int?
    //	let discount_percentage : String?
    //	let discount_percentange : Int?
    //	let list_price : Double?
    //	let equalsto : Int?
    let id : String?
    let priceunit : String?
    let pricemoq : ValueWrapper?
    let ref : String?
    //	let promo : Double?
    let sku_status : Int?
    //	let isuom : Bool?
    let display_sku_name : String?
    let cart_id : String?
    var quantity_already_in_cart : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case product_code = "product_code"
        //		case skuID = "skuID"
        //		case buyer_id = "buyer_id"
        case supplier_id = "supplier_id"
        case option = "option"
        //		case original_price = "original_price"
        //		case ismanual_discount = "ismanual_discount"
        //		case discount_amount = "discount_amount"
        //		case discount_percentage = "discount_percentage"
        //		case discount_percentange = "discount_percentange"
        //		case list_price = "list_price"
        //		case equalsto = "equalsto"
        case id = "id"
        case priceunit = "priceunit"
        case pricemoq = "pricemoq"
        case ref = "ref"
        //		case promo = "promo"
        case sku_status = "sku_status"
        //		case isuom = "isuom"
        case display_sku_name = "display_sku_name"
        case cart_id = "cart_id"
        case quantity_already_in_cart = "quantity_already_in_cart"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
        //		skuID = try values.decodeIfPresent(String.self, forKey: .skuID)
        //		buyer_id = try values.decodeIfPresent(String.self, forKey: .buyer_id)
        supplier_id = try values.decodeIfPresent(String.self, forKey: .supplier_id)
        option = try values.decodeIfPresent(String.self, forKey: .option)
        //		original_price = try values.decodeIfPresent(Double.self, forKey: .original_price)
        //		ismanual_discount = try values.decodeIfPresent(Bool.self, forKey: .ismanual_discount)
        //		discount_amount = try values.decodeIfPresent(Int.self, forKey: .discount_amount)
        //		discount_percentage = try values.decodeIfPresent(String.self, forKey: .discount_percentage)
        //		discount_percentange = try values.decodeIfPresent(Int.self, forKey: .discount_percentange)
        //		list_price = try values.decodeIfPresent(Double.self, forKey: .list_price)
        //		equalsto = try values.decodeIfPresent(Int.self, forKey: .equalsto)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        priceunit = try values.decodeIfPresent(String.self, forKey: .priceunit)
        pricemoq = try values.decodeIfPresent(ValueWrapper.self, forKey: .pricemoq)
        ref = try values.decodeIfPresent(String.self, forKey: .ref)
        //		promo = try values.decodeIfPresent(Double.self, forKey: .promo)
        sku_status = try values.decodeIfPresent(Int.self, forKey: .sku_status)
        //		isuom = try values.decodeIfPresent(Bool.self, forKey: .isuom)
        display_sku_name = try values.decodeIfPresent(String.self, forKey: .display_sku_name)
        cart_id = try values.decodeIfPresent(String.self, forKey: .cart_id)
        quantity_already_in_cart = try values.decodeIfPresent(Double.self, forKey: .quantity_already_in_cart)
    }
    
}
