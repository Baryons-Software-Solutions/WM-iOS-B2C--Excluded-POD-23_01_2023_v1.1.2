
//  Updated by Avinash on 11/03/23.
import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class PaymentSdkTransactionDetails {
    public var transactionReference : String?
    public var transactionType : String?
    public var cartId : String?
    public var cartDescription : String?
    public var cartCurrency : String?
    public var cartAmount : Int?
    public var payResponseReturn : String?
    public var paymentResult : PaymentResult?
    public var paymentInfo : PaymentInfo?
    public var redirectUrl : String?
    public var errorCode : String?
    public var errorMsg : String?
    public var token : String?
    public var billingDetails : BillingDetails?
    public var shippingDetails : ShippingDetails?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let paymentSdkTransactionDetails_list = PaymentSdkTransactionDetails.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of PaymentSdkTransactionDetails Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [PaymentSdkTransactionDetails]
    {
        var models:[PaymentSdkTransactionDetails] = []
        for item in array
        {
            models.append(PaymentSdkTransactionDetails(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let paymentSdkTransactionDetails = PaymentSdkTransactionDetails(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: PaymentSdkTransactionDetails Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        transactionReference = dictionary["transactionReference"] as? String
        transactionType = dictionary["transactionType"] as? String
        cartId = dictionary["cartId"] as? String
        cartDescription = dictionary["cartDescription"] as? String
        cartCurrency = dictionary["cartCurrency"] as? String
        cartAmount = dictionary["cartAmount"] as? Int
        payResponseReturn = dictionary["payResponseReturn"] as? String
        if (dictionary["paymentResult"] != nil) { paymentResult = PaymentResult(dictionary: dictionary["paymentResult"] as! NSDictionary) }
        if (dictionary["paymentInfo"] != nil) { paymentInfo = PaymentInfo(dictionary: dictionary["paymentInfo"] as! NSDictionary) }
        redirectUrl = dictionary["redirectUrl"] as? String
        errorCode = dictionary["errorCode"] as? String
        errorMsg = dictionary["errorMsg"] as? String
        token = dictionary["token"] as? String
        if (dictionary["billingDetails"] != nil) { billingDetails = BillingDetails(dictionary: dictionary["billingDetails"] as! NSDictionary) }
        if (dictionary["shippingDetails"] != nil) { shippingDetails = ShippingDetails(dictionary: dictionary["shippingDetails"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.transactionReference, forKey: "transactionReference")
        dictionary.setValue(self.transactionType, forKey: "transactionType")
        dictionary.setValue(self.cartId, forKey: "cartId")
        dictionary.setValue(self.cartDescription, forKey: "cartDescription")
        dictionary.setValue(self.cartCurrency, forKey: "cartCurrency")
        dictionary.setValue(self.cartAmount, forKey: "cartAmount")
        dictionary.setValue(self.payResponseReturn, forKey: "payResponseReturn")
        dictionary.setValue(self.paymentResult?.dictionaryRepresentation(), forKey: "paymentResult")
        dictionary.setValue(self.paymentInfo?.dictionaryRepresentation(), forKey: "paymentInfo")
        dictionary.setValue(self.redirectUrl, forKey: "redirectUrl")
        dictionary.setValue(self.errorCode, forKey: "errorCode")
        dictionary.setValue(self.errorMsg, forKey: "errorMsg")
        dictionary.setValue(self.token, forKey: "token")
        dictionary.setValue(self.billingDetails?.dictionaryRepresentation(), forKey: "billingDetails")
        dictionary.setValue(self.shippingDetails?.dictionaryRepresentation(), forKey: "shippingDetails")
        
        return dictionary
    }
    
}
