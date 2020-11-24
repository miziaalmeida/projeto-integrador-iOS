//
//  BelongsToCollection.swift
//  testApiPI
//
//  Created by Michel dos Santos on 12/11/20.
//

import Foundation


class BelongsToCollection : NSObject, NSCoding{

    var backdropPath : String!
    var id : Int!
    var name : String!
    var posterPath : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        backdropPath = dictionary["backdrop_path"] as? String
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        posterPath = dictionary["poster_path"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if backdropPath != nil{
            dictionary["backdrop_path"] = backdropPath
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if posterPath != nil{
            dictionary["poster_path"] = posterPath
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         backdropPath = aDecoder.decodeObject(forKey: "backdrop_path") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if backdropPath != nil{
            aCoder.encode(backdropPath, forKey: "backdrop_path")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if posterPath != nil{
            aCoder.encode(posterPath, forKey: "poster_path")
        }

    }

}
