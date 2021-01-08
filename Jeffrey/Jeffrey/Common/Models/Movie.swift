//
//    Result.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Movie : NSObject, NSCoding{

    var adult : Bool!
    var backdropPath : String!
    var genreIds : [Int]!
    var id : Int!
    var originalLanguage : String!
    var originalTitle : String!
    var overview : String!
    var popularity : Float!
    var posterPath : String!
    var releaseDate : String!
    var title : String!
    var video : Bool!
    var voteAverage : Double!
    var voteCount : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        adult = dictionary["adult"] as? Bool
        backdropPath = dictionary["backdrop_path"] as? String
        genreIds = dictionary["genre_ids"] as? [Int]
        id = dictionary["id"] as? Int
        originalLanguage = dictionary["original_language"] as? String
        originalTitle = dictionary["original_title"] as? String
        overview = dictionary["overview"] as? String
        popularity = dictionary["popularity"] as? Float
        posterPath = dictionary["poster_path"] as? String
        releaseDate = dictionary["release_date"] as? String
        title = dictionary["title"] as? String
        video = dictionary["video"] as? Bool
        voteAverage = dictionary["vote_average"] as? Double
        voteCount = dictionary["vote_count"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if adult != nil{
            dictionary["adult"] = adult
        }
        if backdropPath != nil{
            dictionary["backdrop_path"] = backdropPath
        }
        if genreIds != nil{
            dictionary["genre_ids"] = genreIds
        }
        if id != nil{
            dictionary["id"] = id
        }
        if originalLanguage != nil{
            dictionary["original_language"] = originalLanguage
        }
        if originalTitle != nil{
            dictionary["original_title"] = originalTitle
        }
        if overview != nil{
            dictionary["overview"] = overview
        }
        if popularity != nil{
            dictionary["popularity"] = popularity
        }
        if posterPath != nil{
            dictionary["poster_path"] = posterPath
        }
        if releaseDate != nil{
            dictionary["release_date"] = releaseDate
        }
        if title != nil{
            dictionary["title"] = title
        }
        if video != nil{
            dictionary["video"] = video
        }
        if voteAverage != nil{
            dictionary["vote_average"] = voteAverage
        }
        if voteCount != nil{
            dictionary["vote_count"] = voteCount
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         adult = aDecoder.decodeObject(forKey: "adult") as? Bool
         backdropPath = aDecoder.decodeObject(forKey: "backdrop_path") as? String
         genreIds = aDecoder.decodeObject(forKey: "genre_ids") as? [Int]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         originalLanguage = aDecoder.decodeObject(forKey: "original_language") as? String
         originalTitle = aDecoder.decodeObject(forKey: "original_title") as? String
         overview = aDecoder.decodeObject(forKey: "overview") as? String
         popularity = aDecoder.decodeObject(forKey: "popularity") as? Float
         posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String
         releaseDate = aDecoder.decodeObject(forKey: "release_date") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         video = aDecoder.decodeObject(forKey: "video") as? Bool
         voteAverage = aDecoder.decodeObject(forKey: "vote_average") as? Double
         voteCount = aDecoder.decodeObject(forKey: "vote_count") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if adult != nil{
            aCoder.encode(adult, forKey: "adult")
        }
        if backdropPath != nil{
            aCoder.encode(backdropPath, forKey: "backdrop_path")
        }
        if genreIds != nil{
            aCoder.encode(genreIds, forKey: "genre_ids")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if originalLanguage != nil{
            aCoder.encode(originalLanguage, forKey: "original_language")
        }
        if originalTitle != nil{
            aCoder.encode(originalTitle, forKey: "original_title")
        }
        if overview != nil{
            aCoder.encode(overview, forKey: "overview")
        }
        if popularity != nil{
            aCoder.encode(popularity, forKey: "popularity")
        }
        if posterPath != nil{
            aCoder.encode(posterPath, forKey: "poster_path")
        }
        if releaseDate != nil{
            aCoder.encode(releaseDate, forKey: "release_date")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if video != nil{
            aCoder.encode(video, forKey: "video")
        }
        if voteAverage != nil{
            aCoder.encode(voteAverage, forKey: "vote_average")
        }
        if voteCount != nil{
            aCoder.encode(voteCount, forKey: "vote_count")
        }

    }

}
