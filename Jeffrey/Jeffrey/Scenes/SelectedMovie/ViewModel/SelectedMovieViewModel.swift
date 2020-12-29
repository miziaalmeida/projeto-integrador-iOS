//
//  SelectedMovieViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 26/11/20.
//

import UIKit

enum nameProviders: String{
    case netflix = "Netflix"
    case HBOGo = "HBO Go"
    case telecine = "Telecine Play"
    case now = "NOW"
    case claro = "Claro video"
    case looke = "Looke"
    case netMovies = "NetMovies"
    case disney = "Disney Plus"
    case globo = "Globo Play"
    case tnt = "TNTGo"
}

protocol SelectedMovieViewModelProtocol: AnyObject{
    func getImageFilm() -> UIImage
    func setArrayMovies(arrayMovie: [Movie])
    func getOverView( ) -> String
    func getTitle() -> String
    func getRelease() -> String
    func getVoteAverage() -> String
    func getImageStreaming() -> String
    func addMovieArrayFavorites()
    func addMovieArraySeen()
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void)
    func raffle( completion: @escaping (Bool) -> Void) 
    func setNameProvider(providerName: String)
}

class SelectedMovieViewModel:SelectedMovieViewModelProtocol{
    
    //MARK: VARIÁVEIS
    private var arrayMovies = [Movie]() // Onde será carregado a request da API
    private var idPageApi = 2 // Alterar a pagina na requisição da API
    private var genre = 28 // ID do gênero para a requisicão na API! Fixo 28 para testes! obs: Acão
    private var idProvider = 8 // testar
    private var providerName : String?
    var idPage: Int = 8 // obs: page da app por padrão começa na primeira
    var idMovieInArray = 0 // Indice do Filme no array de Filmes, é alterado cada vez que é sorteado um novo filme.
    
    var arrayMovieFavorites = [Movie]() // Lista Filmes Favorios
    var arrayMovieSeen = [Movie]() // Lista Filmes Já Vistos
    var arrayMovieFilterProvider = [Movie]()
    
    var selectedMovieAPI = SelectedMovieAPI()
    private var customSegmentedControll = CustomSegmentControl()
    
    //MARK: FUNCS
    func raffle( completion: @escaping (Bool) -> Void){
        // se a lista for vazia, faz o request de umas lista de filmes
        if arrayMovieFilterProvider .isEmpty {
            raffleListOfAPIMovies { sucess in
                
                self.checkProvidersOfMovies { sucess in
                    
                    if sucess{
                        print("array filtrado encontro \(self.arrayMovieFilterProvider.count) filmes no provedor")
                        
                        completion(true)
                        return
                    }
                }
            }
        } // se array não for vazio
            if idMovieInArray < arrayMovieFilterProvider.count - 1 && arrayMovieFilterProvider.count > 1  {
                newMovieInArray()
                
                completion(true)
                return
            }else{
                print("aquii")
                arrayMovies = [Movie]()
                arrayMovieFilterProvider = [Movie]()
                idMovieInArray = 0
                idPage += 1
//                completion(false)
//                return
                
                raffleListOfAPIMovies { sucess in
                    
                    self.checkProvidersOfMovies { sucess in
                        
                        if sucess{
                            print("array filtrado encontro \(self.arrayMovieFilterProvider.count) filmes no provedor")
                            
                            completion(true)
                            return
                        }
                    }
                }
    
            }

        
    }
    
    // sortear uma lista de filmes
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void) {
        
        selectedMovieAPI.listOfFilms(idPage: idPage) { arrayMovies in
            print("nova requi e o id da pag é \(self.idPage)")
            self.setArrayMovies(arrayMovie: arrayMovies)
            completion(true)
            return
        }
    }
    
    func newMovieInArray(){
        idMovieInArray += 1
        
    }

    func checkProvidersOfMovies( completion: @escaping (Bool) -> Void) {
        
        for movie in arrayMovies{
            
            if let idMovie = movie.id{
                selectedMovieAPI.getProviders(idMovie: idMovie) { arrayFlatrate in
                    
                    if self.providerSelected(provider: nameProviders.telecine.rawValue, flatrates: arrayFlatrate){
                        self.arrayMovieFilterProvider.append(movie)
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
        
        let idImage =  arrayMovieFilterProvider[idMovieInArray].posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
        let data = try? Data(contentsOf: url!)
        return  UIImage(data: data!)!
    }
    
    func getOverView() -> String {
        return arrayMovieFilterProvider[idMovieInArray].overview
    }
    
    func getTitle() -> String {
        
        if let tittle = arrayMovieFilterProvider [idMovieInArray].title{
            return tittle
        }
         
        return ""
    }
    
    func getRelease() -> String {
        return arrayMovieFilterProvider[idMovieInArray].releaseDate
    }
    
    func getVoteAverage() -> String {
        let nota = arrayMovieFilterProvider[idMovieInArray].voteAverage!
        //        return "\(nota) / 10 ⭐  "
        return "\(nota) ⭐"
    }
    
    func getImageStreaming() -> String{
        if let providerName = providerName{
            return providerName
        }
        return "star"
    }
    
    func addMovieArrayFavorites() {
        arrayMovieFavorites.append(arrayMovies[idMovieInArray])
    }
    
    func addMovieArraySeen() {
        arrayMovieSeen.append(arrayMovies[idMovieInArray ])
        
    }

}
