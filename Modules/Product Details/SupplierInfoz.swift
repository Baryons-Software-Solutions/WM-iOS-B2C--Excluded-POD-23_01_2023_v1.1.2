
//  Updated by Avinash on 11/03/23.
import Foundation
struct SupplierInfoz: Codable {
    let _id : String?
    let is_offline : Bool?
    let company_name : String?
    let company_registration_no : String?
    let address : String?
    let country : String?
    let city : String?
    let pobox : String?
    let firstname : String?
    let middlename : String?
    let lastname : String?
    let profile : String?
    let business_type : String?
    let business_type_other : String?
    let phone_number_code : String?
    let mobile_no_code : String?
    let phone_number : String?
    let mobile_no : String?
    let email : String?
    let alt_email : String?
    let password : String?
    let w_name : String?
    let w_address : String?
    let w_phone : String?
    let platform : String?
    let admin_rights : Int?
    let approval_workflow_settings : String?
    let is_deleted : Int?
    let status : Int?
    let status_name : String?
    //	let on_boarding_status : Int?
    let on_boarding_status_name : String?
    let buyer_supplier : String?
    let owner_buyer_no : String?
    let email_notification : Int?
    let phone_notification : Int?
    let created_by : String?
    let updated_by : String?
    let created_by_id : String?
    let updated_by_id : String?
    let updated_at : String?
    let created_at : String?
    let on_boarding_assigned_to : String?
    let on_boarding_assigned_to_name : String?
    let on_boarding_date : String?
    let isblock : String?
    let isfavourit : String?
    let profile_id : String?
    let ratings : Double
    let tRN_No : String?
    let license : String?
    let trn_certificate : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case is_offline = "is_offline"
        case company_name = "company_name"
        case company_registration_no = "company_registration_no"
        case address = "address"
        case country = "country"
        case city = "city"
        case pobox = "pobox"
        case firstname = "firstname"
        case middlename = "middlename"
        case lastname = "lastname"
        case profile = "profile"
        case business_type = "business_type"
        case business_type_other = "business_type_other"
        case phone_number_code = "phone_number_code"
        case mobile_no_code = "mobile_no_code"
        case phone_number = "phone_number"
        case mobile_no = "mobile_no"
        case email = "email"
        case alt_email = "alt_email"
        case password = "password"
        case w_name = "w_name"
        case w_address = "w_address"
        case w_phone = "w_phone"
        case platform = "platform"
        case admin_rights = "admin_rights"
        case approval_workflow_settings = "approval_workflow_settings"
        case is_deleted = "is_deleted"
        case status = "status"
        case status_name = "status_name"
        //		case on_boarding_status = "on_boarding_status"
        case on_boarding_status_name = "on_boarding_status_name"
        case buyer_supplier = "buyer_supplier"
        case owner_buyer_no = "owner_buyer_no"
        case email_notification = "email_notification"
        case phone_notification = "phone_notification"
        case created_by = "created_by"
        case updated_by = "updated_by"
        case created_by_id = "created_by_id"
        case updated_by_id = "updated_by_id"
        case updated_at = "updated_at"
        case created_at = "created_at"
        case on_boarding_assigned_to = "on_boarding_assigned_to"
        case on_boarding_assigned_to_name = "on_boarding_assigned_to_name"
        case on_boarding_date = "on_boarding_date"
        case isblock = "isblock"
        case isfavourit = "isfavourit"
        case profile_id = "profile_id"
        case ratings = "ratings"
        case tRN_No = "TRN_No"
        case license = "license"
        case trn_certificate = "trn_certificate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        is_offline = try values.decodeIfPresent(Bool.self, forKey: .is_offline)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        company_registration_no = try values.decodeIfPresent(String.self, forKey: .company_registration_no)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        pobox = try values.decodeIfPresent(String.self, forKey: .pobox)
        firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
        middlename = try values.decodeIfPresent(String.self, forKey: .middlename)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        profile = try values.decodeIfPresent(String.self, forKey: .profile)
        business_type = try values.decodeIfPresent(String.self, forKey: .business_type)
        business_type_other = try values.decodeIfPresent(String.self, forKey: .business_type_other)
        phone_number_code = try values.decodeIfPresent(String.self, forKey: .phone_number_code)
        mobile_no_code = try values.decodeIfPresent(String.self, forKey: .mobile_no_code)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        mobile_no = try values.decodeIfPresent(String.self, forKey: .mobile_no)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        alt_email = try values.decodeIfPresent(String.self, forKey: .alt_email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        w_name = try values.decodeIfPresent(String.self, forKey: .w_name)
        w_address = try values.decodeIfPresent(String.self, forKey: .w_address)
        w_phone = try values.decodeIfPresent(String.self, forKey: .w_phone)
        platform = try values.decodeIfPresent(String.self, forKey: .platform)
        admin_rights = try values.decodeIfPresent(Int.self, forKey: .admin_rights)
        approval_workflow_settings = try values.decodeIfPresent(String.self, forKey: .approval_workflow_settings)
        is_deleted = try values.decodeIfPresent(Int.self, forKey: .is_deleted)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        status_name = try values.decodeIfPresent(String.self, forKey: .status_name)
        //		on_boarding_status = try values.decodeIfPresent(Int.self, forKey: .on_boarding_status)
        on_boarding_status_name = try values.decodeIfPresent(String.self, forKey: .on_boarding_status_name)
        buyer_supplier = try values.decodeIfPresent(String.self, forKey: .buyer_supplier)
        owner_buyer_no = try values.decodeIfPresent(String.self, forKey: .owner_buyer_no)
        email_notification = try values.decodeIfPresent(Int.self, forKey: .email_notification)
        phone_notification = try values.decodeIfPresent(Int.self, forKey: .phone_notification)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        updated_by_id = try values.decodeIfPresent(String.self, forKey: .updated_by_id)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        on_boarding_assigned_to = try values.decodeIfPresent(String.self, forKey: .on_boarding_assigned_to)
        on_boarding_assigned_to_name = try values.decodeIfPresent(String.self, forKey: .on_boarding_assigned_to_name)
        on_boarding_date = try values.decodeIfPresent(String.self, forKey: .on_boarding_date)
        isblock = try values.decodeIfPresent(String.self, forKey: .isblock)
        isfavourit = try values.decodeIfPresent(String.self, forKey: .isfavourit)
        profile_id = try values.decodeIfPresent(String.self, forKey: .profile_id)
        ratings = try values.decodeIfPresent(Double.self, forKey: .ratings) ?? 0.0
        tRN_No = try values.decodeIfPresent(String.self, forKey: .tRN_No)
        license = try values.decodeIfPresent(String.self, forKey: .license)
        trn_certificate = try values.decodeIfPresent(String.self, forKey: .trn_certificate)
    }
    
}
