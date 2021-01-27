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

protocol SelectedMovieViewModelProtocol: AnyObject{
    func getImageFilm() -> UIImage
    func getOverView( ) -> String
    func getTitle() -> String
    func getRelease() -> String
    func getVoteAverage() -> String
    func getImageStreaming() -> String
    func getGenre() -> String
    func getArrayFavorites() -> [Movie]
    func getArraySee() -> [Movie]
    func addMovieArrayFavorites()
    func addMovieArraySeen()
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void)
    func setNameProvider(providerName: String)
    func setMovieSearchBar(movie:Movie)
    func setNameProvider()
    func setIdGenre(id: Int)
    func setIdProvider(id: Int)
    func setArrayMovies(arrayMovie: [Movie])
    func redirectTap()
    var viewController: SelectedViewEvents? {get set}
}

class SelectedMovieViewModel:SelectedMovieViewModelProtocol{
    
    
    
    weak var viewController: SelectedViewEvents?
    
    
    
    
    
    //MARK: VARIÁVEIS
    private var arrayMovies = [Movie]() // Onde será carregado a request da API
    private var genreId = idGenres.animation.rawValue// ID do gênero para a requisicão na
    private var providerName  = nameProviders.netflix.rawValue
    private var idProvider  = idProviders.netflix.rawValue
    private var idPageApi = 1 // Alterar a pagina na requisição da API
    var idPage: Int = 1 // obs: page da app por padrão começa na primeira
    var idMovieInArray = 0 // Indice do Filme no array de Filmes, é alterado cada vez que é sorteado um novo filme.
    
    static var arrayMovieFavorites = [Movie]() // Lista Filmes Favorios
    static var arrayMovieSeen = [Movie]() // Lista Filmes Já Vistos
    static var arrayMovieFilterProvider = [Movie]()
    var movieSearchBar:Movie?
    var apiManager = APIManager()
    //    private var customSegmentedControll = CustomSegmentControl()
    
    //MARK: FUNCS
    
    // sortear uma lista de filmes
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void) {
        if arrayMovies .isEmpty {
            apiManager.listOfFilms(idPage: idPage, genre: genreId, provider: idProvider) { arrayMovies in
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
    
    
    //    func checkProvidersOfMovies( completion: @escaping (Bool) -> Void) {
    //
    //        for movie in arrayMovies{
    //
    //            if let idMovie = movie.id{
    //                APIManager.getProviders(idMovie: idMovie) { arrayFlatrate in
    //
    //                    if self.providerSelected(provider: self.providerName, flatrates: arrayFlatrate){
    //                        SelectedMovieViewModel.arrayMovieFilterProvider.append(movie)
    //                        completion(true)
    //                        return
    //                    }
    //                }
    //            }
    //
    //        }
    //    }
    //
    //
    //    func providerSelected(provider: String, flatrates: [Flatrate]) -> Bool{
    //        setNameProvider(providerName: provider)
    //        for flatrate in flatrates{
    //
    //            if flatrate.providerName == provider{
    //                return true
    //            }
    //        }
    //        return false
    //    }
    
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
            if let tittle = arrayMovies[idMovieInArray].title{
                return tittle
            }
            
        }
        
        return ""
    }
    
    func getRelease() -> String {
        if arrayMovies.isEmpty{
             return formatDate(date: (movieSearchBar?.releaseDate)!)
        }
        return formatDate(date: arrayMovies[idMovieInArray].releaseDate)
    }
    
    func getVoteAverage() -> String {
        let nota = String(arrayMovies[idMovieInArray].voteAverage)
        return "\(nota) ⭐"
    }
    
    func getImageStreaming() -> String{
        return providerName
    }
    
    func setMovieSearchBar(movie:Movie){
        movieSearchBar = movie
        
        
    }
    
    
    func setNameProvider() {
        switch idProvider {
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
        case idProviders.netMovie.rawValue:
            providerName = nameProviders.netMovies.rawValue
        default:
            providerName = nameProviders.netflix.rawValue
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
        case idGenres.terror.rawValue:
            return "\(nameGenres.terror.rawValue)"
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
    
    func setIdGenre(id: Int){
        genreId = id
    }
    
    func setIdProvider(id: Int){
        idProvider = id
    }
    
    
    
    func redirectTap() {
        guard  let homeViewControler = UIStoryboard(name: " Redirect",
                                                    bundle: nil).instantiateInitialViewController() as? RedirectViewController else { return }
        
        homeViewControler.movieName = getTitle()
        homeViewControler.providerName = getImageStreaming()
        
        viewController?.present(viewController: homeViewControler)
    }
    
    func formatDate(date:String) -> String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"

        let date: NSDate? = dateFormatterGet.date(from: String(date)) as NSDate?
        print(dateFormatterPrint.string(from: date! as Date))
        
        return dateFormatterPrint.string(from: date! as Date)
    }
    
    
    
}

