//
//  Flatrate.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 10/12/20.
//

import Foundation

class Flatrate : NSObject, NSCoding{

    var displayPriority : Int!
    var logoPath : String!
    var providerId : Int!
    var providerName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        displayPriority = dictionary["display_priority"] as? Int
        logoPath = dictionary["logo_path"] as? String
        providerId = dictionary["provider_id"] as? Int
        providerName = dictionary["provider_name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if displayPriority != nil{
            dictionary["display_priority"] = displayPriority
        }
        if logoPath != nil{
            dictionary["logo_path"] = logoPath
        }
        if providerId != nil{
            dictionary["provider_id"] = providerId
        }
        if providerName != nil{
            dictionary["provider_name"] = providerName
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         displayPriority = aDecoder.decodeObject(forKey: "display_priority") as? Int
         logoPath = aDecoder.decodeObject(forKey: "logo_path") as? String
         providerId = aDecoder.decodeObject(forKey: "provider_id") as? Int
         providerName = aDecoder.decodeObject(forKey: "provider_name") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if displayPriority != nil{
            aCoder.encode(displayPriority, forKey: "display_priority")
        }
        if logoPath != nil{
            aCoder.encode(logoPath, forKey: "logo_path")
        }
        if providerId != nil{
            aCoder.encode(providerId, forKey: "provider_id")
        }
        if providerName != nil{
            aCoder.encode(providerName, forKey: "provider_name")
        }

    }

}
