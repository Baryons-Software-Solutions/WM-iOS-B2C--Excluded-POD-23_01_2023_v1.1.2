
//  Updated by Avinash on 11/03/23.
import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class ShippingDetails {
    public var city : String?
    public var countryCode : String?
    public var email : String?
    public var name : String?
    public var phone : Int?
    public var state : String?
    public var addressLine : String?
    public var zip : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let shippingDetails_list = ShippingDetails.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of ShippingDetails Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [ShippingDetails]
    {
        var models:[ShippingDetails] = []
        for item in array
        {
            models.append(ShippingDetails(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let shippingDetails = ShippingDetails(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: ShippingDetails Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        city = dictionary["city"] as? String
        countryCode = dictionary["countryCode"] as? String
        email = dictionary["email"] as? String
        name = dictionary["name"] as? String
        phone = dictionary["phone"] as? Int
        state = dictionary["state"] as? String
        addressLine = dictionary["addressLine"] as? String
        zip = dictionary["zip"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.city, forKey: "city")
        dictionary.setValue(self.countryCode, forKey: "countryCode")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.state, forKey: "state")
        dictionary.setValue(self.addressLine, forKey: "addressLine")
        dictionary.setValue(self.zip, forKey: "zip")
        
        return dictionary
    }
    
}
