//
//  Movie.swift
//  testApiPI
//
//  Created by Michel dos Santos on 12/11/20.
//

import Foundation


//
//    Movie.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport




class Movie : NSObject, NSCoding{

    var adult : Bool!
    var backdropPath : String!
    var belongsToCollection : BelongsToCollection!
    var budget : Int!
    var genres : [Genre]!
    var homepage : String!
    var id : Int!
    var imdbId : String!
    var originalLanguage : String!
    var originalTitle : String!
    var overview : String!
    var popularity : Float!
    var posterPath : String!
    var productionCompanies : [ProductionCompany]!
    var productionCountries : [ProductionCountry]!
    var releaseDate : String!
    var revenue : Int!
    var runtime : Int!
    var spokenLanguages : [SpokenLanguage]!
    var status : String!
    var tagline : String!
    var title : String!
    var video : Bool!
    var voteAverage : Float!
    var voteCount : Int!


    init(fromDictionary dictionary: [String:Any]){
        adult = dictionary["adult"] as? Bool
        backdropPath = dictionary["backdrop_path"] as? String
        if let belongsToCollectionData = dictionary["belongs_to_collection"] as? [String:Any]{
            belongsToCollection = BelongsToCollection(fromDictionary: belongsToCollectionData)
        }
        budget = dictionary["budget"] as? Int
        genres = [Genre]()
        if let genresArray = dictionary["genres"] as? [[String:Any]]{
            for dic in genresArray{
                let value = Genre(fromDictionary: dic)
                genres.append(value)
            }
        }
        homepage = dictionary["homepage"] as? String
        id = dictionary["id"] as? Int
        imdbId = dictionary["imdb_id"] as? String
        originalLanguage = dictionary["original_language"] as? String
        originalTitle = dictionary["original_title"] as? String
        overview = dictionary["overview"] as? String
        popularity = dictionary["popularity"] as? Float
        posterPath = dictionary["poster_path"] as? String
        productionCompanies = [ProductionCompany]()
        if let productionCompaniesArray = dictionary["production_companies"] as? [[String:Any]]{
            for dic in productionCompaniesArray{
                let value = ProductionCompany(fromDictionary: dic)
                productionCompanies.append(value)
            }
        }
        productionCountries = [ProductionCountry]()
        if let productionCountriesArray = dictionary["production_countries"] as? [[String:Any]]{
            for dic in productionCountriesArray{
                let value = ProductionCountry(fromDictionary: dic)
                productionCountries.append(value)
            }
        }
        releaseDate = dictionary["release_date"] as? String
        revenue = dictionary["revenue"] as? Int
        runtime = dictionary["runtime"] as? Int
        spokenLanguages = [SpokenLanguage]()
        if let spokenLanguagesArray = dictionary["spoken_languages"] as? [[String:Any]]{
            for dic in spokenLanguagesArray{
                let value = SpokenLanguage(fromDictionary: dic)
                spokenLanguages.append(value)
            }
        }
        status = dictionary["status"] as? String
        tagline = dictionary["tagline"] as? String
        title = dictionary["title"] as? String
        video = dictionary["video"] as? Bool
        voteAverage = dictionary["vote_average"] as? Float
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
        if belongsToCollection != nil{
            dictionary["belongs_to_collection"] = belongsToCollection.toDictionary()
        }
        if budget != nil{
            dictionary["budget"] = budget
        }
        if genres != nil{
            var dictionaryElements = [[String:Any]]()
            for genresElement in genres {
                dictionaryElements.append(genresElement.toDictionary())
            }
            dictionary["genres"] = dictionaryElements
        }
        if homepage != nil{
            dictionary["homepage"] = homepage
        }
        if id != nil{
            dictionary["id"] = id
        }
        if imdbId != nil{
            dictionary["imdb_id"] = imdbId
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
        if productionCompanies != nil{
            var dictionaryElements = [[String:Any]]()
            for productionCompaniesElement in productionCompanies {
                dictionaryElements.append(productionCompaniesElement.toDictionary())
            }
            dictionary["production_companies"] = dictionaryElements
        }
        if productionCountries != nil{
            var dictionaryElements = [[String:Any]]()
            for productionCountriesElement in productionCountries {
                dictionaryElements.append(productionCountriesElement.toDictionary())
            }
            dictionary["production_countries"] = dictionaryElements
        }
        if releaseDate != nil{
            dictionary["release_date"] = releaseDate
        }
        if revenue != nil{
            dictionary["revenue"] = revenue
        }
        if runtime != nil{
            dictionary["runtime"] = runtime
        }
        if spokenLanguages != nil{
            var dictionaryElements = [[String:Any]]()
            for spokenLanguagesElement in spokenLanguages {
                dictionaryElements.append(spokenLanguagesElement.toDictionary())
            }
            dictionary["spoken_languages"] = dictionaryElements
        }
        if status != nil{
            dictionary["status"] = status
        }
        if tagline != nil{
            dictionary["tagline"] = tagline
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
         belongsToCollection = aDecoder.decodeObject(forKey: "belongs_to_collection") as? BelongsToCollection
         budget = aDecoder.decodeObject(forKey: "budget") as? Int
         genres = aDecoder.decodeObject(forKey :"genres") as? [Genre]
         homepage = aDecoder.decodeObject(forKey: "homepage") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imdbId = aDecoder.decodeObject(forKey: "imdb_id") as? String
         originalLanguage = aDecoder.decodeObject(forKey: "original_language") as? String
         originalTitle = aDecoder.decodeObject(forKey: "original_title") as? String
         overview = aDecoder.decodeObject(forKey: "overview") as? String
         popularity = aDecoder.decodeObject(forKey: "popularity") as? Float
         posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String
         productionCompanies = aDecoder.decodeObject(forKey :"production_companies") as? [ProductionCompany]
         productionCountries = aDecoder.decodeObject(forKey :"production_countries") as? [ProductionCountry]
         releaseDate = aDecoder.decodeObject(forKey: "release_date") as? String
         revenue = aDecoder.decodeObject(forKey: "revenue") as? Int
         runtime = aDecoder.decodeObject(forKey: "runtime") as? Int
         spokenLanguages = aDecoder.decodeObject(forKey :"spoken_languages") as? [SpokenLanguage]
         status = aDecoder.decodeObject(forKey: "status") as? String
         tagline = aDecoder.decodeObject(forKey: "tagline") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         video = aDecoder.decodeObject(forKey: "video") as? Bool
         voteAverage = aDecoder.decodeObject(forKey: "vote_average") as? Float
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
        if belongsToCollection != nil{
            aCoder.encode(belongsToCollection, forKey: "belongs_to_collection")
        }
        if budget != nil{
            aCoder.encode(budget, forKey: "budget")
        }
        if genres != nil{
            aCoder.encode(genres, forKey: "genres")
        }
        if homepage != nil{
            aCoder.encode(homepage, forKey: "homepage")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if imdbId != nil{
            aCoder.encode(imdbId, forKey: "imdb_id")
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
        if productionCompanies != nil{
            aCoder.encode(productionCompanies, forKey: "production_companies")
        }
        if productionCountries != nil{
            aCoder.encode(productionCountries, forKey: "production_countries")
        }
        if releaseDate != nil{
            aCoder.encode(releaseDate, forKey: "release_date")
        }
        if revenue != nil{
            aCoder.encode(revenue, forKey: "revenue")
        }
        if runtime != nil{
            aCoder.encode(runtime, forKey: "runtime")
        }
        if spokenLanguages != nil{
            aCoder.encode(spokenLanguages, forKey: "spoken_languages")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if tagline != nil{
            aCoder.encode(tagline, forKey: "tagline")
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
