
//  Updated by Avinash on 11/03/23.
import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class PaymentResult {
    public var responseCode : String?
    public var responseMessage : String?
    public var responseStatus : String?
    public var transactionTime : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [PaymentResult]
    {
        var models:[PaymentResult] = []
        for item in array
        {
            models.append(PaymentResult(dictionary: item as! NSDictionary)!)
        }
        return models
    }

    required public init?(dictionary: NSDictionary) {
        
        responseCode = dictionary["responseCode"] as? String
        responseMessage = dictionary["responseMessage"] as? String
        responseStatus = dictionary["responseStatus"] as? String
        transactionTime = dictionary["transactionTime"] as? String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.responseCode, forKey: "responseCode")
        dictionary.setValue(self.responseMessage, forKey: "responseMessage")
        dictionary.setValue(self.responseStatus, forKey: "responseStatus")
        dictionary.setValue(self.transactionTime, forKey: "transactionTime")
        
        return dictionary
    }
    
}
