//
//  Constant.swift
//  Order_Now_GIT
//
//  Created by Mac on 16/06/20.
//  Updated By Avinash on 11/03/23
//  Copyright © 2020 Mac. All rights reserved.

//This constatnt class used for all API's invoking. and created some variable for string constant mesaages

import UIKit

let APPDELEGATE = UIApplication.shared.delegate as? AppDelegate
let USERDEFAULTS = UserDefaults.standard
let NOTIFICATIONCENTER = NotificationCenter.default
let BUNDLE = Bundle.main
let MAIN_SCREEN = UIScreen.main
let SCREEN_WIDTH: CGFloat = MAIN_SCREEN.bounds.width
let SCREEN_HEIGHT = MAIN_SCREEN.bounds.height
let SCREEN_SCALE: CGFloat = MAIN_SCREEN.bounds.width / 320
let kIphone_4s: Bool = (SCREEN_HEIGHT == 480)
let kIphone_5: Bool = (SCREEN_HEIGHT == 568)
let kIphone_6: Bool = (SCREEN_HEIGHT == 667)
let kIphone_6_Plus: Bool = (SCREEN_HEIGHT == 736)
let kIphone_X: Bool = (SCREEN_HEIGHT == 812)

let iPAD = UIDevice.current.userInterfaceIdiom == .pad

// MARK: - Print
func PRINT(_ data: Any) {
#if DEBUG
    print(data)
#endif
}

// MARK: iOS Version
func IOS_VERSION_EQUAL_TO(val: String) -> Bool {
    return UIDevice.current.systemVersion.compare(val, options: .numeric) == .orderedSame
}
func IOS_VERSION_GREATER_THAN(val: String) -> Bool {
    return UIDevice.current.systemVersion.compare(val, options: .numeric) == .orderedDescending
}
func IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(val: String) -> Bool {
    return UIDevice.current.systemVersion.compare(val, options: .numeric) != .orderedAscending
}
func IOS_VERSION_LESS_THAN(val: String) -> Bool {
    return UIDevice.current.systemVersion.compare(val, options: .numeric) == .orderedAscending
}
func IOS_VERSION_LESS_THAN_OR_EQUAL_TO(val: String) -> Bool {
    return UIDevice.current.systemVersion.compare(val, options: .numeric) != .orderedAscending
}

let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let menuStoryBoard = UIStoryboard.init(name: "Menu", bundle: nil)

let AuthenticationStoryboard = UIStoryboard.init(name: "Authentication", bundle: nil)

func checkNullString(value: Any) -> String {
    var str = ""
    // var str = String.init(format: "%ld", value as! CVarArg)
    if let val = value as? NSString {
        str = val as String
    } else if let val = value as? NSNumber {
        str = val.stringValue
    } else if let val = value as? Double {
        str = String.init(format: "%ld", val)
    } else if let val = value as? Int {
        str = String.init(format: "%ld", val)
    } else if value is NSNull {
        str = ""
    } else {
        str = ""
    }
    return str
}

//-------------------------------------------------------------------------------------------//
//-*-*-*-*-*-*--*-*-*-*-*-*-*-*-*-*AllMessageString-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*-*-*-*-//
//-------------------------------------------------------------------------------------------//



let NetworkConnection  = "You are not connected to internet. Please connect and try again"
let msgValidEmail                       = "Please provide valid email address"
let msgEmail                            = "Please provide email address"
let msgTerms                            = "Please provide terms & conditions"
let msgTermsConditions                  = "By clicking this you are agreed to Terms & conditions"
let msgReferralCode                     = "Please provide referral code"
let msgLogoutAlert                      = "Are you sure you want to logout?"
let msgProfileUpdate                    = "Profile information updated successfully"
let msgUnexpectedError                  = "Unexpected erros. Please contact customer care"
let msgSessionExpire                    = "Your session has been expired, please login again"
let msgEmailRequire                     = "Please configure mail application to continue"
let msgNotificationPermissionRequired   = "Notification Permission Required"
let msgEnableNotificationFromSettings   = "Please enable notification permissions in settings"
let msgLocationPermissionRequired       = "Location Permission Required"
let msgEnableLocationFromSettings       = "Please enable location permissions in settings"
let msgDisableLocationFromSettings      = "Please disable location permissions in settings"
let msgPhoneNumber                      = "Please enter phone number"
let msgServerNotReachable               = "Server is in maintenance, please try again later"
let msgSlowingDown                      = "Feel like slowing down?"
let msgNotConnectedNetworkAlert         = "Uh-oh! Looks like you’re not connected to the internet"


enum FontName: String {
    //typealias RawValue = Int
    
    case robotoMedium = "Roboto-Medium"
    case robotoBold = "Roboto-Bold"
    case robotoRegular = "Roboto-Regular"
    case robotoSemiBold = "Roboto-SemiBold"
    
}

func font(name: FontName, size: CGFloat) -> UIFont {
    return UIFont.init(name: name.rawValue, size: size)!
}

func localization(localKey: String?) -> String {
    return localKey!
    //return UtilityClass.getLanguageLabelWithKey(key: localKey!)
}

func versionInfo() -> (version: String, build: String) {
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as? String
    let build = dictionary["CFBundleVersion"] as? String
    return(version ?? "", build ?? "")
}

func addActivityAtFooter(tableView: UITableView, isShow: Bool) {
    DispatchQueue.main.async {
        if tableView.tableFooterView == nil || !(tableView.tableFooterView is FooterView) {
            let views = FooterView().loadNib() as? FooterView
            views?.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: tableView.bounds.width, height: 50))
            tableView.tableFooterView = views
            views?.activityView.startAnimating()
            views?.backgroundColor = UIColor.clear
        }
        if  let views = tableView.tableFooterView as? FooterView {
            if isShow {
                views.frame.size.height = 50
                tableView.tableFooterView = views
                views.activityView.startAnimating()
            } else {
                views.frame.size.height = 0.1
                tableView.tableFooterView = views
                views.activityView.stopAnimating()
            }
        }
    }
}

struct Constants {
    
    // MARK: - Global Utility
    
    static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - GlobalConstants
    
    struct GlobalConstants {
        static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
        static let appDelegate = UIApplication.shared.delegate as! AppDelegate
        static let iPhoneStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
    }
    
    // MARK: - Font Name
    
    struct Font {
        static let openSansRegular       = "OpenSans"
        static let openSansBold          = "OpenSans-Bold"
        static let openSansSemibold      = "OpenSans-Semibold"
        static let latoBold              = "Lato-Bold"
        static let latoReg              = "Lato"
    }
    
    // MARK: - StoryBoard Identifiers
    
    struct StoryBoardID{
        static let kWelcomeID = "WelcomeVC"
        static let kLoginID = "LoginVC"
        static let kRegisterID = "RegisterVC"
        static let kSidemenuID = "SidemenuVC"
        static let kDashboardID = "DashboardVC"
        static let kSportsID = "SportsVC"
        static let kMusicalsID = "MusicalsVC"
        static let kConcertsID = "ConcertsVC"
        static let kComediansID = "ComediansVC"
        static let kManageSportsID = "ManageSportsVC"
        static let kAddRemoveSportTeamID = "AddRemoveSportsTeamVC"
        static let kEventDetailID = "EventDetailVC"
        static let kConnectionsID = "ConnectionsVC"
        static let kContactID = "ContactVC"
        static let kAddedConnectionsID = "AddedConnectionVC"
        static let kProfileID = "ProfileVC"
        static let kChangePasswordID = "ChangePasswordVC"
        static let kAboutUsID = "AboutUsVC"
        static let kManageMusicalsID = "ManageMusicalVC"
        static let kRemoveMusicalsID = "RemoveMusicalsVC"
        static let kManageComediansID = "ManageComediansVC"
        static let kRemoveComediansID = "RemoveComediansVC"
        static let kManageConecertsID = "ManageConcertsVC"
        static let kRemoveConecertsID = "RemoveConcertsVC"
        static let kPopularShowsID = "PopularShowsVC"
    }
    
    // MARK: - Device ScreenSize
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    // MARK: - Device Type
    
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPADMin           = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1112.0
        static let IS_IPADLarge         = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    }
    
    // MARK: - WebService URLs
    
    struct WebServiceURLs {
        
        //        static let mainURL = "http://35.154.99.45/watermelon-api-quality/public/api/v1/"
        //        static let fetchPhotoURL = "http://35.154.99.45/watermelon-api-quality/public/upload/upload_photo/"
        
        //Development
        //        static let fetchPhotoURL = "http://35.154.99.45/watermelon-api/public/upload/upload_photo/"
        //                static let mainURL = "http://35.154.99.45/watermelon-api/public/api/v1/"
        
        //QA
        //static let fetchPhotoURL = "https://qaapi.watermelon.market/upload/upload_photo/"
        //        static let mainURL = "https://api.watermelon.market/index.php/api/v1/"
        
        //  static let fetchPhotoURL = "https://api.watermelon.market/upload/upload_photo/"
        
        
        //Production/Lives
        //        static let fetchProductDetailsPhotoURL =  "https://api.watermelon.market/upload/upload_photo/"
        //        static let mainURL = "https://api.watermelon.market/index.php/api/v1/"
        //        static let fetchPhotoURL = "https://api.watermelon.market/upload/upload_photo/"
        
        //Staging
        static let fetchProductDetailsPhotoURL = "https://stagingapi.watermelon.market/upload/upload_photo/"
        static let mainURL = "https://stagingapi.watermelon.market/index.php/api/v1/"
        static let fetchPhotoURL = "https://stagingapi.watermelon.market/upload/upload_photo/"
        
        //Preproduction
        //        static let fetchProductDetailsPhotoURL =  "https://apiwatermelonpreprod.baryons.net/upload/upload_photo/"
        //        static let mainURL = "https://apiwatermelonpreprod.baryons.net/index.php/api/v1/"
        
        
        static let registerSupplierURL = mainURL + "suppliers/create"
        static let registerBuyerURL = mainURL + "buyers/create"
        static let scheduleDemoURL = mainURL + "schedule/create"
        static let contactUsURL = mainURL + "contactus/create"
        static let loginURL = mainURL + "login"
        static let changepasswordURL = mainURL + "changepassword"
        static let referralsURL = mainURL + "referrals/create"
        
        static let cartListURL = mainURL + "carts?platform=mobile&fcm_token_ios=\(USERDEFAULTS.getDataForKey(.fcmToken))"
        static let cartDeleteURL = mainURL + "carts/destroy"
        static let cartUpdateProductURL = mainURL + "carts/update-product"
        static let cartAddCustomProductURL = mainURL + "carts/add-custom-product"
        static let cartUpdateCustomProductURL = mainURL + "carts/update-custom-product"
        static let cartDeleteProductURL = mainURL + "carts/remove-product"
        static let OrderAddCustomProductURL = mainURL + "orders/add-custom-product"
        static let OrderUpdateCustomProductURL = mainURL + "orders/update-custom-product"
        
        static let NotificationsURL = mainURL + "notifications"
        static let NotificationsUnreadURL = mainURL + "notifications/unread"
        static let NotificationsMarkAsRead = mainURL + "notifications/markAsread_for_moblie"
        static let supplierProfileURL = mainURL + "suppliers"
        
        static let cartSupplierNotesURL = mainURL + "carts/supplier-notes"
        static let cartProductNotesURL = mainURL + "carts/product-notes"
        static let cartDeliveryAddressURL = mainURL + "carts/update-delivery-address"
        static let cartDeliveryDateAvailabilityURL = mainURL + "carts/check-delivery-availability"
        static let UpdateDeliveryAddressSupplierURL = mainURL + "orders/update-delivery-address"
        
        static let removeFavouriteSupplierURL = mainURL + "buyers/remove_favourit_suppliers"
        
        static let addToFavouriteSupplierURL = mainURL + "favourite/create"
        static let addToBlockSupplierURL = mainURL + "buyers/add_to_block_suppliers"
        static let wishlistDelete = mainURL + "removeWishlist"
        static let warehouseListURL = mainURL + "warehouses"
        static let buyerListURL = mainURL + "buyers"
        static let outletListURL = mainURL + "outlets"
        static let briefURL = mainURL + "dashboard/brief"
        
        static let updateOutletURL = mainURL + "outlets/update"
        static let addOutletURL = mainURL + "outlets/create"
        
        // static let suppliersListURL = mainURL + "suppliers"
        static let suppliersListURL = mainURL + "marketplace/suppliers"
        static let productListURL = mainURL + "marketplace/products"
        static let newHomeUrl = mainURL + "HomePageAPis"
        
        static let suppliersFilterListURL = mainURL + "buyers/mySupplierFilter"
        static let FavouritesListURL = mainURL + "buyers/myFavSupplierFilter"
        static let ProductDetailURL = mainURL + "products/producMarketplaceFilter"
        static let DraftOrdersURL = mainURL + "draft-orders"
        static let DraftOrdersViewURL = mainURL + "draft-orders/view"
        static let DraftApproveOrderURL = mainURL + "draft-orders/approve"
        static let DraftRejectOrderURL = mainURL + "draft-orders/reject"
        
        static let DraftSupplierNotesURL = mainURL + "draft-orders/supplier-notes"
        static let DraftProductNotesURL = mainURL + "draft-orders/product-notes"
        static let DraftUpdateProductURL = mainURL + "draft-orders/update-product"
        static let DraftDeleteProductFromOrderURL = mainURL + "draft-orders/remove-product"
        static let DraftDeliveryDateAvailabilityURL = mainURL + "draft-orders/check-delivery-availability"
        static let UpdateDeliveryDateURL = mainURL + "orders/update-delivery-date"
        static let UpdateProductSupplierURL = mainURL + "orders/update-product"
        static let UpdateReceivedQtyURL = mainURL + "orders/update-received-quantity"
        
        static let SpendingsPerWeekURL = mainURL + "dashboard/spendings-per-week"
        static let SpendingsYTDURL = mainURL + "dashboard/spendings-year-till-date"
        static let SpendingsLastTwelveWeekURL = mainURL + "dashboard/spendings-last-twelve-weeks"
        static let SpendingsPerDateRangeURL = mainURL + "dashboard/spendings-date-range"
        
        static let SpendingsPerCategoryURL = mainURL + "dashboard/spendings-per-category"
        
        static let ReportSpendingPerSupplier = mainURL + "reports/spendings-per-supplier"
        static let ReportSpendingPerCategory = mainURL + "reports/spendings-per-category"
        static let ReportSpendingPerOutlet = mainURL + "reports/spendings-per-outlet"
        
        static let ReportSpendingPerSubCategory = mainURL + "reports/spendings-per-sub-category"
        static let ReportSpendingPerCategoryDetail = mainURL + "reports/spendings-per-category-details"
        static let ReportSpendingPerOutletDetail = mainURL + "reports/spendings-per-outlet-details"
        
        static let DraftAddCustomProductURL = mainURL + "draft-orders/add-custom-product"
        static let DraftUpdateCustomProductURL = mainURL + "draft-orders/update-custom-product"
        static let DraftDeleteURL = mainURL + "draft-orders/delete"
        static let DeleteProductbySupplierURL = mainURL + "orders/remove-product"
        
        static let DraftOrderUpdateDeliveryAddressURL = mainURL + "draft-orders/update-delivery-address"
        
        static let OrderUpdateStatusURL = mainURL + "orders/update-status"
        static let OrderCloseURL = mainURL + "orders/close-order"
        static let OrderReturnedURL = mainURL + "orders/order-returned"
        static let OrderCompletedURL = mainURL + "orders/mark-as-completed"
        static let ProcessCartURL = mainURL + "carts/process"
        static let GenerateInvoiceURL = mainURL + "invoices/generate"
        
        static let OrderBuyerListURL = mainURL + "orders/buyer-list"
        static let OrderBuyerListViewURL = mainURL + "orders/view"
        static let PendingOrderListViewURL = mainURL + "draft-orders/view"
        
        static let OrderSupplierListURL = mainURL + "orders/supplier-list"
        static let UpcomingDeliveriesURL = mainURL + "dashboard/upcoming-deliveries"
        
        static let InvoicesBuyerListURL = mainURL + "invoices/buyer-list"
        static let InvoicesSupplierListURL = mainURL + "invoices/supplier-list"
        static let RatingsURL = mainURL + "ratings"
        
        static let InvoicesViewURL = mainURL + "invoices/view"
        static let InvoicesStatusUpdateURL = mainURL + "invoices/update-status"
        static let PaymentBuyerListURL = mainURL + "payments/buyer-list"
        static let PaymentSupplierListURL = mainURL + "payments/supplier-list"
        static let DownloadOrderURL = mainURL + "orders/download-order?order_id="
        static let DownloadInvoiceURL = mainURL + "invoices/download-invoice?invoice_id="
        
        static let ReceivePaymentURL = mainURL + "payments/receive"
        static let PayNowURL = mainURL + "payments/transaction"
        
        //static let AddToCartURL = mainURL + "carts/create"
        static let AddToCartURL = mainURL + "carts/add-product"
        static let FilterSupplier = mainURL + "supbuymap"
        static let FilterPricing = mainURL + "getPriceFilterList"
        static let BrandList    = mainURL + "getBarndList"
        static let RequestQuoteURL = mainURL + "products/requestaQuoteEmail"
        
        static let CreateRatingURL = mainURL + "ratings/create"
        static let UpdateRatingURL = mainURL + "ratings/update"
        static let DeleteRatingURL = mainURL + "ratings/delete"
        
        static let addWarehouseURL = mainURL + "warehouses/create"
        static let updateWarehouseURL = mainURL + "warehouses/update"
        static let changeStatusWarehouseURL = mainURL + "warehouses/changeStatus"
        static let changeStatusOutletURL = mainURL + "outlets/changeStatus"
        static let pricingCheck  = mainURL + "carts/process-verification"
        
        static let updateProfileURL = mainURL + "users/update"
        static let viewProfileURL = mainURL + "users/"
        
        static let ForgotPasswordURL = mainURL + "forgotpassword"
        static let UsersURL = mainURL + "users"
        static let ParametersURL = mainURL + "parameters"
        static let CategoryURL = mainURL + "category"
        static let SubCategoryURL = mainURL + "subcategory"
        static let ProductDetailsURL = mainURL + "products/view_product_details"
        static let AddWishlistURL = mainURL + "wishlist/add"
        static let RemoveWishlistURL = mainURL + "removeWishlist"
        static let ConfigurationsURL = mainURL + "configurations"
        static let NeedHelpURL = mainURL + "homesupport/create"
        static let WishlistURL = mainURL + "wishlist"
        static let addSupplierBuyURL = mainURL + "supbuymap/create"
        static let supplierDeleteURL = mainURL + "carts/delete-supplier-cart"
        static let deleteMyAccount = mainURL + "users/inactivate-profile"
        static let googleLoginURL = mainURL + "social-login"
    }
    
    // MARK: - DateFormat
    
    struct DateFormat {
        static let date = "dd/MM/yy"
        static let time = "hh:mm a"
    }
    
    // MARK: - WebService Parameter
    
    struct WebServiceParameter {
        //        static let paramFullName = "fullname"
        //        static let paramUserID = "user_id"
        //        //static let paramName = "name"
        //        static let paramFirstname = "firstname"
        //        static let paramLastname = "lastname"
        //        static let paramEmailID = "email_id"
        //        static let paramEmail = "email"
        //        static let paramPassword = "password"
        //        static let paramConfirmPassword = "cpassword"
        //        static let paramMobileNumber = "mobile_no"
        //        static let paramZipcode = "zip_code"
        //        static let paramDeviceToken = "device_token"
        //        static let paramDeviceType = "device_type"
        //        static let paramUsername = "username"
        
        static let paramPincode = "pincode"
        static let paramState = "state"
        
        static let paramAddressId = "address_id"
        static let paramCategoryName = "category_name"
        //static let paramDescription = "description"
        static let paramPopularCategory = "popular_category"
        static let paramStatus = "status"
        static let paramCategoryId = "category_id"
        
        static let paramProductID = "prod_id"
        static let paramName = "name"
        static let paramDescription = "description"
        static let paramProductCode = "product_code"
        static let paramQuantity = "quantity"
        static let paramPrice = "price"
        static let paramGST = "GST"
        static let paramCategory = "category"
        static let paramCartProductID = "cart_product_id"
        static let paramProductQty = "product_qty"
        static let paramDeliveryAddressId = "delivery_address_id"
        
        static let paramPostcode = "postcode"
        static let paramUserId = "user_id"
        static let paramId = "id"
        static let paramIdiOS = "id_ios"
        
        static let paramCatId = "cat_id"
        static let paramShopperId = "shopper_id"
        static let paramProducts = "products"
        //static let paramProductId = "product_id"
        static let paramCpid = "cpid"
        static let paramSuburb = "suburb"
        static let paramDeliveryId = "delivery_id"
        static let paramOrgName = "org_name"
        static let paramABN = "abn"
        static let paramPhone = "phone"
        static let paramUsertype = "user_type"
        static let paramUsertypeId = "user_type_id"
        static let paramRoleId = "role_id"
        static let paramPermission = "permission"
        
        static let paramSort = "sort_method"
        static let paramSortBy = "sortBy"
        static let paramStart = "start"
        static let paramPage = "page"
        
        static let paramEnd = "end"
        static let paramOrderId = "order_id"
        static let paramTemplateId = "template_id"
        static let paramTemplateName = "template_name"
        static let paramLoginFrom = "login_from"
        static let paramShoppers = "shoppers"
        static let paramMessage = "message"
        static let paramSearch = "search"
        static let paramKeyword = "keyword"
        static let paramORDdate = "ord_date"
        static let paramRecOrder = "rec_ord"
        static let paramProccedOrder = "procced_ord"
        static let paramFeedback1 = "feedback_1"
        static let paramFeedback2 = "feedback_2"
        static let paramFromDate = "from_date"
        static let paramToDate = "to_date"
        
        
        static let paramPlatform = "platform"
        
        static let paramEmail = "email"
        static let paramAlternateEmail = "alt_email"
        static let paramPassword = "password"
        static let paramConfirmPassword = "confirmpassword"
        static let paramOldPassword = "old_password"
        static let paramNewPassword = "new_password"
        static let paramConfirm_Password = "confirm_password"
        
        static let paramTierApproval = "tier_approval"
        static let paramLevel = "level"
        static let paramValue = "value"
        static let paramNotified = "notified"
        static let paramDesignation = "designation"
        
        static let paramCpassword = "cpassword"
        static let paramCompanyName = "company_name"
        static let paramCompanyRegistrationNo = "company_registration_no"
        static let paramAddress = "address"
        static let paramCountry = "country"
        static let paramCity = "city"
        static let paramArea = "area"
        
        static let paramPobox = "pobox"
        static let paramFirstname = "firstname"
        static let paramMiddlename = "middlename"
        static let paramLastname = "lastname"
        static let paramNumWarehouse = "no_warehouse"
        static let paramBusinessType = "business_type"
        static let paramTypeOfBusiness = "business_type"
        static let paramSpecialFeature = "special_feature"
        static let paramPhoneNumber = "phone_number"
        static let paramMobileNo = "mobile_no"
        static let paramMobileNumbercode = "mobile_no_code"
        
        static let paramMobileNumber = "mobile_number"
        static let paramWarehouseAddress = "w_address"
        static let paramWName = "w_name"
        static let paramWarehousePhone = "w_phone"
        static let paramCuisineType = "cuisine_type"
        static let paramTypeOfCuisine = "type_of_cuisine"
        static let paramOutletLocation = "outlet_location"
        
        static let paramAboutUs = "about_us"
        static let paramOther = "other"
        static let paramStartDate = "start_date"
        static let paramEndDate = "end_date"
        static let paramStartTime = "start_time"
        static let paramEndTime = "end_time"
        static let paramTimeSlot = "time_slot"
        static let paramTimezone = "time_zone"
        static let paramOtherFeatures = "other_features"
        static let paramIam = "i_am"
        static let paramNumOfOutlet = "no_outlet"
        static let paramNumOfBuyers = "no_buyers"
        static let paramNumberOfWarehouse = "no_wherehouse"
        static let paramCode = "code"
        static let paramReasonId = "reason_id"
        static let paramRemark = "remark"
        static let paramCountryCode = "phone_number_code"
        static let paramFirst_name = "first_name"
        static let paramMiddle_name = "middle_name"
        static let paramLast_name = "last_name"
        static let paramSupplierId = "supplier_id"
        static let paramWarehouseName = "warehouse_name"
        static let paramOutletName = "outlet_name"
        static let paramBuyerId = "buyer_id"
        static let paramAdminRights = "admin_rights"
        static let paramTag = "tags"
        static let paramAssignUser = "outlet_user"
        static let paramWarehouseUser = "warehouse_user"
        static let trnNo = "TRN_No"
        
        static let paramBillingAddress = "billing_address"
        static let paramBillingCountry = "billing_country"
        static let paramBillingCity = "billing_city"
        static let paramBillingArea = "billing_area"
        static let paramOutletUser = "outlet_user"
        static let paramMobileCountryCode = "mobile_country_code"
        static let dob = "BirthDate"
        
    }
    
    
    // MARK: - Alert Messages
    
    struct AlertMessage {
        static let noTRN = "No TRN found"
        static let noResult = "No Result Found"
        static let inProgress = "In Progress"
        static let NetworkConnection  = "You are not connected to internet. Please connect and try again"
        static let msgSlowNetworkConnection = "We are unable to retrieve the data at this time, please try again"
        static let contactUs = "Your query has been submitted successfully"
        
        static let cameraPermission = "Please enable camera access from Privacy Settings"
        static let photoLibraryPermission = "Please enable access for photos from Privacy Settings"
        static let noCamera = "Device Has No Camera"
        
        static let comingSoon = "Coming Soon"
        static let noConnectedUsers = "No Connected Users"
        static let noTeamsAdded = "No Teams Added"
        
        static let name = "Name is required"
        static let nameCharacter = "Name must contain atleast 3 characters and maximum 50 characters"
        static let validName = "Please enter valid Name"
        //static let address = "Please enter Address"
        
        static let selectState = "Please select State"
        //static let city = "Please enter City"
        static let pincode = "Please enter Pincode"
        
        static let fullName = "Please enter Full name"
        //static let firstName = "Please enter First name"
        static let shopName = "Please enter Shop name"
        static let ABN = "Please enter ABN"
        static let validABN = "Please enter valid ABN with 11 digit"
        
        static let supplierName = "Please enter Supplier name"
        
        //static let lastName = "Please enter Last name"
        static let validEmail = "Please enter valid Email"
        //static let email = "Please enter Email"
        //static let password = "Please enter Password"
        // static let confirmPassword = "Please enter Confirm password"
        static let SamePassword = "Passwords don't match"
        static let passwordCharacter = "Password must contain atleast 8 characters and maximum 15 characters"
        static let validPassword = "Password must be between 6 to 16 characters,\n contain at least one  letter, \n one digit and \n one special character."
        
        //static let validPassword = "Password should contain atleast one uppercase letter, one lowercase letter, one digit and one special character with minimum 8 character length."
        static let spacePassword = "Please remove whitespace from Password"
        //static let phone = "Please enter Phone number"
        static let referralCode = "Please enter Referral code"
        
        static let phoneCharacter = "Please enter valid Mobile no."
        static let validPhone = "Phone number should be in digit only"
        static let error = "Something went wrong. Please try after sometime"
        static let productName = "Product name is required"
        static let productCode = "Please enter Product code"
        static let removeWhiteSpace = "Please remove white space from Product code"
        
        static let selectCategory = "Please select Category"
        static let price = "Please enter Price"
        static let minimumOrderQty = "Please enter minimum Order quanitity"
        static let gst = "Please enter GST"
        static let valiGST = "Please enter valid GST"
        
        static let categoryName = "Please enter Category name"
        static let categoryDesc = "Please enter Category description"
        static let selectStatus = "Please select Status"
        
        static let suburb = "Please enter Suburb"
        static let postcode = "Please enter Postcode"
        static let templateName = "Please enter Template name"
        static let cardNumber = "Please enter valid Card number"
        static let cardYear = "Please enter Expiry year"
        static let cardMonth = "Please enter Expiry month"
        static let cardHolder = "Please enter Card holder name"
        static let cardCVV = "Please enter Card security code"
        static let message = "Message is required"
        static let terms = "Terms are required!"
        static let validPincode = "Please enter Pincode"
        static let selectProduct = "Please select atleast one Product"
        static let feature = "Please enter Feature experience"
        static let experience = "Please enter Experience"
        static let selectDate = "Please select Delivery date"
        static let company = "Company Name is required"
        static let date = "Date is required"
        
        static let companyName = "Name of Company is required"
        static let registrationNumber = "Registration No is required"
        static let address = "Address is required"
        static let country = "Country is required"
        static let city = "City is required"
        static let area = "Area is required"
        static let countryCode = "Country Code is required"
        
        static let houseHoldName = "House hold name is required"
        static let dob = "Date of birth is required"
        static let dobInvalid = "Date of birth is invalid.\nPlease enter it in MMDDYY format"
        
        static let poBox = "PO Box is required"
        static let firstName = "Name is required"
        static let middleName = "Middle ename is required"
        static let lastName = "Last name is required"
        static let buisnessNature = "Nature of Business is required"
        static let remark = "Remark is required"
        
        static let numberOfWarehouse = "No of Warehouses is required"
        static let buisnessType = "Business Type is required"
        static let cuisineType = "Cuisine Type is required"
        static let specialFeature = "Special Feature is required"
        static let otherFeature = "Other Feature is required"
        static let tag = "Tag is required"
        static let assignUser = "Assign User is required"
        static let phoneNumber = "Phone No is required"
        static let mobileNumber = "Mobile Number is required"
        static let email = "Email is required"
        static let password = "Password is required"
        static let currentpassword = " Current Password is required"
        static let oldPassword = "Old Password is required"
        static let newPassword = "New Password is required"
        static let confirmPassword = "Confirm Password is required"
        static let validFirstName = "Valid First name required"
        static let validLastName = "Last name is required"
        static let validMiddleName = "Valid Middle name required"
        static let wareHouseName = "Warehouse name is required"
        static let wareHouseAddress = "Warehouse address is required"
        static let wareHousePhone = "Warehouse Phonenumber is required"
        static let field = "This field is required"
        static let startDate = "Start Date is required"
        static let endDate = "End Date is required"
        static let startTime = "Start Time is required"
        static let endTime = "End Time is required"
        static let timeslot = "Time Slot is required"
        
        static let selectUser = "User type is required"
        static let outlets = "No of Outlets is required"
        static let business = "Type of Business is required"
        static let buyers = "No of Buyers is required"
        static let timezone = "Timezone is required"
        
        static let outletName = "Outlet name is required"
        static let registration = "Registration ID is required"
        static let outletAddress = "Outlet address is required"
        static let outletPhone = "Outlet phonenumber is required"
        static let status = "Status is required"
        static let deliveryAddress = "Delivery Address is required"
        static let billingAddress = "Billing address is required"
        static let billingCountry = "Country is required"
        static let billingCity = "City is required"
        static let billingArea = "Area is required"
        static let notes = "Notes is required"
        static let sku = "SKU is required"
        static let qty = "Quantity is required"
        static let desc = "Description is required"
        static let warehouse = "Warehouse is required"
        static let modeOfPaymnet = "Mode of Payment is required"
        static let amount = "Amount is required"
        static let toDate = "To date is required"
        static let fromDate = "From date is required"
        
    }
}
