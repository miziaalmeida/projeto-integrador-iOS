//
//  ProductionCountry.swift
//  testApiPI
//
//  Created by Michel dos Santos on 12/11/20.
//

import Foundation


class ProductionCountry : NSObject, NSCoding{

    var iso31661 : String!
    var name : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        iso31661 = dictionary["iso_3166_1"] as? String
        name = dictionary["name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if iso31661 != nil{
            dictionary["iso_3166_1"] = iso31661
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         iso31661 = aDecoder.decodeObject(forKey: "iso_3166_1") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if iso31661 != nil{
            aCoder.encode(iso31661, forKey: "iso_3166_1")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }

    }

}
