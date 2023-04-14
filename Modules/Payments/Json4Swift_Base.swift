
//  Updated by Avinash on 11/03/23.

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Json4Swift_Base {
    public var paymentSdkTransactionDetails : PaymentSdkTransactionDetails?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Json4Swift_Base Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Json4Swift_Base]
    {
        var models:[Json4Swift_Base] = []
        for item in array
        {
            models.append(Json4Swift_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Json4Swift_Base Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["PaymentSdkTransactionDetails"] != nil) { paymentSdkTransactionDetails = PaymentSdkTransactionDetails(dictionary: dictionary["PaymentSdkTransactionDetails"] as! NSDictionary) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.paymentSdkTransactionDetails?.dictionaryRepresentation(), forKey: "PaymentSdkTransactionDetails")
        
        return dictionary
    }
    
}
