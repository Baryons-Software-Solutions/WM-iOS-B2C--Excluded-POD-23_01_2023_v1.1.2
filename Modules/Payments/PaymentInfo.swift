
//  Updated by Avinash on 11/03/23.
import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class PaymentInfo {
    public var cardScheme : String?
    public var cardType : String?
    public var paymentDescription : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let paymentInfo_list = PaymentInfo.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of PaymentInfo Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [PaymentInfo]
    {
        var models:[PaymentInfo] = []
        for item in array
        {
            models.append(PaymentInfo(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let paymentInfo = PaymentInfo(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: PaymentInfo Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        cardScheme = dictionary["cardScheme"] as? String
        cardType = dictionary["cardType"] as? String
        paymentDescription = dictionary["paymentDescription"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.cardScheme, forKey: "cardScheme")
        dictionary.setValue(self.cardType, forKey: "cardType")
        dictionary.setValue(self.paymentDescription, forKey: "paymentDescription")
        
        return dictionary
    }
    
}
