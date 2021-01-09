//
//  SelectedMovieViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 26/11/20.
//

import UIKit

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
    case romance = "romance"
    case sciencefiction = "Ficção Científica"
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
    // fazer amazon e apple
    case netflix = "Netflix"//
    case HBOGo = "HBO Go"//
    case telecine = "Telecine Play"//
    case now = "NOW"//
    case claro = "Claro video" //
    case looke = "Looke"
    case netMovies = "NetMovies"
    case disney = "Disney Plus"//
    case globo = "Globo Play"
    case tnt = "TNT Go" //
    case amazon = "Amazon Video"//
    case apple = "Apples"
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
}

protocol SelectedMovieViewModelProtocol: AnyObject{
    func getImageFilm() -> UIImage
    func setArrayMovies(arrayMovie: [Movie])
    func getOverView( ) -> String
    func getTitle() -> String
    func getRelease() -> String
    func getVoteAverage() -> String
    func getImageStreaming() -> String
//    func getTime() -> String
    func getGenre() -> String
    func getArrayFavorites() -> [Movie]
    func getArraySee() -> [Movie]
    func addMovieArrayFavorites()
    func addMovieArraySeen()
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void)
//    func raffle( completion: @escaping (Bool) -> Void)
    func setNameProvider(providerName: String)
    func setMovieSearchBar(movie:Movie)
    func setNameProvider()
    
    

}

class SelectedMovieViewModel:SelectedMovieViewModelProtocol{
   
    
   
    
    
    //MARK: VARIÁVEIS
    private var arrayMovies = [Movie]() // Onde será carregado a request da API
    private var genreId = idGenres.animation.rawValue// ID do gênero para a requisicão na API! Fixo 28 para testes! obs: Acão
    private var providerName  = nameProviders.netflix.rawValue
    private var idProvider  = idProviders.netflix.rawValue
    private var idPageApi = 2 // Alterar a pagina na requisição da API
//    private var idProvider = 8 // testar
    var idPage: Int = 1 // obs: page da app por padrão começa na primeira
    var idMovieInArray = 0 // Indice do Filme no array de Filmes, é alterado cada vez que é sorteado um novo filme.
    
    static var arrayMovieFavorites = [Movie]() // Lista Filmes Favorios
   static var arrayMovieSeen = [Movie]() // Lista Filmes Já Vistos
   static var arrayMovieFilterProvider = [Movie]()
    var movieSearchBar:Movie?
    
    var selectedMovieAPI = SelectedMovieAPI()
    private var customSegmentedControll = CustomSegmentControl()
    
    //MARK: FUNCS
    func raffle( completion: @escaping (Bool) -> Void){
        // se a lista for vazia, faz o request de umas lista de filmes
        if SelectedMovieViewModel.arrayMovieFilterProvider .isEmpty {
            raffleListOfAPIMovies { sucess in

                self.checkProvidersOfMovies { sucess in

                    if sucess{
                        print("array filtrado encontro \(SelectedMovieViewModel.arrayMovieFilterProvider.count) filmes no provedor")

                        completion(true)
                        return
                    }
                }
            }
        } // se array não for vazio
        if idMovieInArray < SelectedMovieViewModel.arrayMovieFilterProvider.count - 1 && SelectedMovieViewModel.arrayMovieFilterProvider.count > 1  {
                newMovieInArray()

                completion(true)
                return
            }else{
                print("aquii")
                arrayMovies = [Movie]()
                SelectedMovieViewModel.arrayMovieFilterProvider = [Movie]()
                idMovieInArray = 0
                idPage += 1
//                completion(false)
//                return

                raffleListOfAPIMovies { sucess in

                    self.checkProvidersOfMovies { sucess in

                        if sucess{
                            print("array filtrado encontro \(SelectedMovieViewModel.arrayMovieFilterProvider.count) filmes no provedor")

                            completion(true)
                            return
                        }
                    }
                }

            }


    }
//
    // sortear uma lista de filmes
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void) {
        if arrayMovies .isEmpty {
            selectedMovieAPI.listOfFilms(idPage: idPage, genre: genreId, provider: idProvider) { arrayMovies in
                print("nova requi e o id da pag é \(self.idPage)")
                self.setArrayMovies(arrayMovie: arrayMovies)
                completion(true)
                return
            }
        }else{
            if idMovieInArray < arrayMovies.count - 1 && arrayMovies.count > 1  {
                newMovieInArray()

                completion(true)
                return
            }else{
                print("aquii")
                arrayMovies = [Movie]()
                SelectedMovieViewModel.arrayMovieFilterProvider = [Movie]()
                idMovieInArray = 0
                idPage += 1


                raffleListOfAPIMovies { sucess in

                        if sucess{
                            

                            completion(true)
                            return
                        }
                    
                }

            }
            
        }
        
    }
    
    func newMovieInArray(){
        idMovieInArray += 1
        
    }

    func checkProvidersOfMovies( completion: @escaping (Bool) -> Void) {
        
        for movie in arrayMovies{
            
            if let idMovie = movie.id{
                selectedMovieAPI.getProviders(idMovie: idMovie) { arrayFlatrate in
                    
                    if self.providerSelected(provider: self.providerName, flatrates: arrayFlatrate){
                        SelectedMovieViewModel.arrayMovieFilterProvider.append(movie)
                        completion(true)
                        return
                    }
                }
            }
            
        }
    }
    
    func providerSelected(provider: String, flatrates: [Flatrate]) -> Bool{
        setNameProvider(providerName: provider)
        for flatrate in flatrates{
           
            if flatrate.providerName == provider{
               
                return true
            }
            
        }
        
        return false
        
    }
    
    //MARK: GET/SET
    func setNameProvider(providerName: String) {
        self.providerName = providerName
    }
    
    func setArrayMovies(arrayMovie: [Movie]) {
        arrayMovies = arrayMovie
    }
    
    func getImageFilm() -> UIImage {
        if arrayMovies.isEmpty{
            let idImage =  movieSearchBar?.posterPath
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
            let data = try? Data(contentsOf: url!)
            return  UIImage(data: data!)!
        }
        let idImage =  arrayMovies[idMovieInArray].posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
        let data = try? Data(contentsOf: url!)
        return  UIImage(data: data!)!
    }
    
    func getOverView() -> String {
        if arrayMovies.isEmpty{
            return (movieSearchBar?.overview)!
        }
        
        return arrayMovies[idMovieInArray].overview
    }
    
    func getTitle() -> String {
        if arrayMovies.isEmpty{
            return (movieSearchBar?.title)!
        }else{
            print(arrayMovies[idMovieInArray].id)
            if let tittle = arrayMovies[idMovieInArray].title{
                return tittle
        }
        
        }
         
        return ""
    }
    
    func getRelease() -> String {
        if arrayMovies.isEmpty{
            return (movieSearchBar?.releaseDate)!
        }
            return arrayMovies[idMovieInArray].releaseDate
        
        
    }
    
    func getVoteAverage() -> String {
        let nota = String(arrayMovies[idMovieInArray].voteAverage)
        //        return "\(nota) / 10 ⭐  "
        return "\(nota) ⭐"
    }
    
    func getImageStreaming() -> String{
        
        return providerName
        
    }
    
    func setMovieSearchBar(movie:Movie){
        movieSearchBar = movie
    }
    
//    func getTime() -> String {
//        let time = String(arrayMovieFilterProvider[idMovieInArray].runtime)
//            return "\(time) min"
//
////        return "0 min"
//    }
    func setNameProvider() {
        switch idProvider {
        case idProviders.netflix.rawValue:
            providerName = nameProviders.netflix.rawValue
        case idProviders.now.rawValue:
            providerName = nameProviders.now.rawValue
        case idProviders.amazon.rawValue:
            providerName = nameProviders.amazon.rawValue
        case idProviders.hbo.rawValue:
            providerName = nameProviders.HBOGo.rawValue
        case idProviders.telecine.rawValue:
            providerName = nameProviders.telecine.rawValue
        case idProviders.claro.rawValue:
            providerName = nameProviders.claro.rawValue
        case idProviders.tnt.rawValue:
            providerName = nameProviders.tnt.rawValue
        case idProviders.disney.rawValue:
            providerName = nameProviders.disney.rawValue
        case idProviders.looke.rawValue:
            providerName = nameProviders.looke.rawValue
        case idProviders.apple.rawValue:
            providerName = nameProviders.apple.rawValue
        case idProviders.globo.rawValue:
            providerName = nameProviders.globo.rawValue
        default:
            ""
        }
    }
    
    func getGenre() -> String{

        switch genreId {
        case idGenres.action.rawValue:
            return "\(nameGenres.action.rawValue)"
        case idGenres.comedy.rawValue:
            return "\(nameGenres.comedy.rawValue)"
        case idGenres.animation.rawValue:
            return "\(nameGenres.animation.rawValue)"
        case idGenres.adventure.rawValue:
            return "\(nameGenres.adventure.rawValue)"
        case idGenres.crime.rawValue:
            return "\(nameGenres.crime.rawValue)"
        case idGenres.documentary.rawValue:
            return "\(nameGenres.documentary.rawValue)"
        case idGenres.drama.rawValue:
            return "\(nameGenres.drama.rawValue)"
        case idGenres.fantasy.rawValue:
            return "\(nameGenres.fantasy.rawValue)"
        case idGenres.Western.rawValue:
            return "\(nameGenres.Western.rawValue)"
        case idGenres.sciencefiction.rawValue:
            return "\(nameGenres.sciencefiction.rawValue)"
        case idGenres.war.rawValue:
            return "\(nameGenres.war)"
        case idGenres.romance.rawValue:
            return "\(nameGenres.romance.rawValue)"
        case idGenres.war.rawValue:
            return "\(nameGenres.war.rawValue)"
            
            
        default:
            return "Indefinido"
        }
        
    }
    
    func getArrayFavorites() -> [Movie]{
        
        return SelectedMovieViewModel.arrayMovieFavorites
    }
    
    func getArraySee() -> [Movie]{
        
        return SelectedMovieViewModel.arrayMovieSeen
    }
    
    func addMovieArrayFavorites() {
        if arrayMovies.isEmpty{
            SelectedMovieViewModel.arrayMovieFavorites.append(movieSearchBar!)
        }else{
            SelectedMovieViewModel.arrayMovieFavorites.append(arrayMovies[idMovieInArray])
        }
        
       
    }
    
    func addMovieArraySeen() {
        if arrayMovies.isEmpty{
            SelectedMovieViewModel.arrayMovieSeen.append(movieSearchBar!)
        }else{
            SelectedMovieViewModel.arrayMovieSeen.append(arrayMovies[idMovieInArray])
        }
        
    }

}

