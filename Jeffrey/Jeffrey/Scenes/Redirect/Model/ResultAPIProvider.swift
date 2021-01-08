//
//  ResultAPIProvider.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 10/12/20.
//

import Foundation

class ResultAPIProvider : NSObject, NSCoding{

    var flatrate : [Flatrate]!
    var link : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        flatrate = [Flatrate]()
        if let flatrateArray = dictionary["flatrate"] as? [[String:Any]]{
            for dic in flatrateArray{
                let value = Flatrate(fromDictionary: dic)
                flatrate.append(value)
            }
        }
        link = dictionary["link"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if flatrate != nil{
            var dictionaryElements = [[String:Any]]()
            for flatrateElement in flatrate {
                dictionaryElements.append(flatrateElement.toDictionary())
            }
            dictionary["flatrate"] = dictionaryElements
        }
        if link != nil{
            dictionary["link"] = link
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         flatrate = aDecoder.decodeObject(forKey :"flatrate") as? [Flatrate]
         link = aDecoder.decodeObject(forKey: "link") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if flatrate != nil{
            aCoder.encode(flatrate, forKey: "flatrate")
        }
        if link != nil{
            aCoder.encode(link, forKey: "link")
        }

    }

}
