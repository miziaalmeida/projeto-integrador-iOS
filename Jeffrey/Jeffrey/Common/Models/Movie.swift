//
//  Movie2.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 29/11/20.
//

import Foundation


class Movie : NSObject, NSCoding{
 
    
    var genres : [Genre]!
    var id : Int!
    var imdbId : String!
    var overview : String!
    var popularity : Float!
    var posterPath : String!
    var releaseDate : String!
    var runtime : Int!
    var title : String!
    var voteAverage : Double!
    var voteCount : Int!
    
    
    init(fromDictionary dictionary: [String:Any]){
 
        genres = [Genre]()
        if let genresArray = dictionary["genres"] as? [[String:Any]]{
            for dic in genresArray{
                let value = Genre(fromDictionary: dic)
                genres.append(value)
            }
        }
        
        id = dictionary["id"] as? Int
        imdbId = dictionary["imdb_id"] as? String
        overview = dictionary["overview"] as? String
        popularity = dictionary["popularity"] as? Float
        posterPath = dictionary["poster_path"] as? String
       
        
       
        releaseDate = dictionary["release_date"] as? String
        
        runtime = dictionary["runtime"] as? Int
        
        
        
        
        title = dictionary["title"] as? String
        
        voteAverage = dictionary["vote_average"] as? Double
        
        voteCount = dictionary["vote_count"] as? Int
    }
    

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if genres != nil{
            var dictionaryElements = [[String:Any]]()
            for genresElement in genres {
                dictionaryElements.append(genresElement.toDictionary())
            }
            dictionary["genres"] = dictionaryElements
        }
        
        if id != nil{
            dictionary["id"] = id
        }
        if imdbId != nil{
            dictionary["imdb_id"] = imdbId
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
        if runtime != nil{
            dictionary["runtime"] = runtime
        }
        if title != nil{
            dictionary["title"] = title
        }
        
        if voteAverage != nil{
            dictionary["vote_average"] = voteAverage
        }
        if voteCount != nil{
            dictionary["vote_count"] = voteCount
        }
        return dictionary
    }

    @objc required init(coder aDecoder: NSCoder)
    {
        genres = aDecoder.decodeObject(forKey :"genres") as? [Genre]
        id = aDecoder.decodeObject(forKey: "id") as? Int
        imdbId = aDecoder.decodeObject(forKey: "imdb_id") as? String
        overview = aDecoder.decodeObject(forKey: "overview") as? String
        popularity = aDecoder.decodeObject(forKey: "popularity") as? Float
        posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String
        releaseDate = aDecoder.decodeObject(forKey: "release_date") as? String
        runtime = aDecoder.decodeObject(forKey: "runtime") as? Int
        title = aDecoder.decodeObject(forKey: "title") as? String
        voteAverage = aDecoder.decodeObject(forKey: "vote_average") as? Double
        voteCount = aDecoder.decodeObject(forKey: "vote_count") as? Int
        
    }
    
    @objc func encode(with aCoder: NSCoder)
    {
        
        
       
        if genres != nil{
            aCoder.encode(genres, forKey: "genres")
        }
        
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imdbId != nil{
            aCoder.encode(imdbId, forKey: "imdb_id")
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
        if runtime != nil{
            aCoder.encode(runtime, forKey: "runtime")
        }
        
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        
        if voteAverage != nil{
            aCoder.encode(voteAverage, forKey: "vote_average")
        }
        if voteCount != nil{
            aCoder.encode(voteCount, forKey: "vote_count")
        }
        
    }
    
}
