
//  Updated by Avinash on 11/03/23.
import Foundation
struct Productz : Codable {
    let _id : String?
    let product_image : String?
    let supplier_product_code : String?
    let number : Int?
    let product_code : String?
    let product_name : String?
    let brand : String?
    let category_id : String?
    let category_name : String?
    let subcategory_id : String?
    let subcategory_name : String?
    let base_uom : String?
    let critical_level : Int?
    let critical_level_alert : String?
    let shelf_life : Int?
    let shelf_daymonth : String?
    let country_of_origin : String?
    let upc_ean_no : String?
    //  let certification : [String]?
    let in_marketplace : Int?
    let display_price : Bool?
    let sku_name : String?
    let lead_time : Int?
    let lead_daymonth : String?
    var pricing_range : [PricingRangez]?
    let rfq : String?
    let user_type_id : String?
    let is_deleted : Int?
    let popularity : Int?
    let status : Int?
    let status_name : String?
    let created_by : String?
    let created_by_id : String?
    let updated_by : String?
    let updated_by_id : String?
    let updated_at : String?
    let created_at : String?
    let gallery_images : [Gallery_images]?
    let hashtag : [String]?
    let long_desc : String?
    let short_desc : String?
    let supplier_info : SupplierInfoz?
    //let estimateFee : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case product_image = "product_image"
        case supplier_product_code = "supplier_product_code"
        case number = "number"
        case product_code = "product_code"
        case product_name = "product_name"
        case brand = "brand"
        case category_id = "category_id"
        case category_name = "category_name"
        case subcategory_id = "subcategory_id"
        case subcategory_name = "subcategory_name"
        case base_uom = "base_uom"
        case critical_level = "critical_level"
        case critical_level_alert = "critical_level_alert"
        case shelf_life = "shelf_life"
        case shelf_daymonth = "shelf_daymonth"
        case country_of_origin = "country_of_origin"
        case upc_ean_no = "upc_ean_no"
        //    case certification = "certification"
        case in_marketplace = "in_marketplace"
        case display_price = "display_price"
        case sku_name = "sku_name"
        case lead_time = "lead_time"
        case lead_daymonth = "lead_daymonth"
        case pricing_range = "pricing_range"
        case rfq = "rfq"
        case user_type_id = "user_type_id"
        case is_deleted = "is_deleted"
        case popularity = "popularity"
        case status = "status"
        case status_name = "status_name"
        case created_by = "created_by"
        case created_by_id = "created_by_id"
        case updated_by = "updated_by"
        case updated_by_id = "updated_by_id"
        case updated_at = "updated_at"
        case created_at = "created_at"
        case gallery_images = "gallery_images"
        case hashtag = "hashtag"
        case long_desc = "long_desc"
        case short_desc = "short_desc"
        case supplier_info = "supplier_info"
        //case estimateFee = "estimateFee"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        product_image = try values.decodeIfPresent(String.self, forKey: .product_image)
        supplier_product_code = try values.decodeIfPresent(String.self, forKey: .supplier_product_code)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
        product_code = try values.decodeIfPresent(String.self, forKey: .product_code)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        subcategory_id = try values.decodeIfPresent(String.self, forKey: .subcategory_id)
        subcategory_name = try values.decodeIfPresent(String.self, forKey: .subcategory_name)
        base_uom = try values.decodeIfPresent(String.self, forKey: .base_uom)
        critical_level = try values.decodeIfPresent(Int.self, forKey: .critical_level)
        critical_level_alert = try values.decodeIfPresent(String.self, forKey: .critical_level_alert)
        shelf_life = try values.decodeIfPresent(Int.self, forKey: .shelf_life)
        shelf_daymonth = try values.decodeIfPresent(String.self, forKey: .shelf_daymonth)
        country_of_origin = try values.decodeIfPresent(String.self, forKey: .country_of_origin)
        upc_ean_no = try values.decodeIfPresent(String.self, forKey: .upc_ean_no)
        //    certification = try values.decodeIfPresent([String].self, forKey: .certification)
        in_marketplace = try values.decodeIfPresent(Int.self, forKey: .in_marketplace)
        display_price = try values.decodeIfPresent(Bool.self, forKey: .display_price)
        sku_name = try values.decodeIfPresent(String.self, forKey: .sku_name)
        lead_time = try values.decodeIfPresent(Int.self, forKey: .lead_time)
        lead_daymonth = try values.decodeIfPresent(String.self, forKey: .lead_daymonth)
        pricing_range = try values.decodeIfPresent([PricingRangez].self, forKey: .pricing_range)
        rfq = try values.decodeIfPresent(String.self, forKey: .rfq)
        user_type_id = try values.decodeIfPresent(String.self, forKey: .user_type_id)
        is_deleted = try values.decodeIfPresent(Int.self, forKey: .is_deleted)
        popularity = try values.decodeIfPresent(Int.self, forKey: .popularity)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        status_name = try values.decodeIfPresent(String.self, forKey: .status_name)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        updated_by_id = try values.decodeIfPresent(String.self, forKey: .updated_by_id)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        gallery_images = try values.decodeIfPresent([Gallery_images].self, forKey: .gallery_images)
        hashtag = try values.decodeIfPresent([String].self, forKey: .hashtag)
        long_desc = try values.decodeIfPresent(String.self, forKey: .long_desc)
        short_desc = try values.decodeIfPresent(String.self, forKey: .short_desc)
        supplier_info = try values.decodeIfPresent(SupplierInfoz.self, forKey: .supplier_info)
        //estimateFee = try values.decodeIfPresent(String.self, forKey: .estimateFee)
    }
    
}
