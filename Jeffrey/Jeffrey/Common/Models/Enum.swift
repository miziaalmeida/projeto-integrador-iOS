//
//  Enum.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 08/02/21.
//

import Foundation

enum nameGenres: String{
    case action = "Ação"
    case animation = "Animação"
    case adventure = "Aventura"
    case comedy = "Comédia"
    case crime = "Crime"
    case documentary = "Documentário"
    case drama = "Drama"
    case fantasy = "Fantasia"
    case terror = "Terror"
    case romance = "Romance"
    case sciencefiction = "Ficção"
    case war = "Guerra"
    case Western = "Faroeste"
}

enum idGenres: Int{
    case action = 28
    case animation = 16
    case adventure = 12
    case comedy = 35
    case crime = 80
    case documentary = 99
    case drama = 18
    case fantasy = 14
    case terror = 27
    case romance = 10749
    case sciencefiction = 878
    case war = 10752
    case Western = 37
}

enum nameProviders: String{
    case netflix = "logo-netflix"//
    case HBOGo = "logo-hboGo"//
    case telecine = "logo-telecine"//
    case now = "logo-now"//
    case claro = "logo-claroVideo" //
    case looke = "logo-Looke"
    case netMovies = "logo-netMovies"
    case disney = "logo-disney+"//
    case globo = "logo-globoplay"
    case tnt = "logo-tntGo" //
    case amazon = "logo-prime"//
    case apple = "logo-appleTV"
    
}

enum idProviders: Int{
    case netflix = 8
    case now = 484
    case apple = 2
    case amazon = 119
    case hbo = 31
    case telecine = 227
    case claro = 167
    case tnt = 512
    case disney = 337
    case looke = 47
    case globo = 307
    case netMovie  = 19
}
