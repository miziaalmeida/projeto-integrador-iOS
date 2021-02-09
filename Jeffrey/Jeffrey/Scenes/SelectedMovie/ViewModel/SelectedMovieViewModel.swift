//
//  SelectedMovieViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 26/11/20.
//

import UIKit

protocol SelectedMovieViewModelProtocol: AnyObject{
    func getImageFilm() -> UIImage
    func getOverView( ) -> String
    func getTitle() -> String
    func getRelease() -> String
    func getVoteAverage() -> String
    func getImageStreaming() -> String
    func getGenre() -> String
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
    func getMovieArrayIndex() -> Movie
    var viewController: SelectedViewEvents? {get set}
    func showActivityIndicator(view: UIView)
}

class SelectedMovieViewModel:SelectedMovieViewModelProtocol{
    
    //MARK: VARIÁVEIS
    var arrayMovies = [Movie]() // Onde será carregado a request da API
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
    var storageFirebase = FirebaseRealtime()
    weak var viewController: SelectedViewEvents?
    
    //MARK: FUNCS
    
    // sortear uma lista de filmes
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void) {
        if arrayMovies .isEmpty {
            apiManager.listOfFilms(idPage: idPage, genre: genreId, provider: idProvider) { arrayMovies in
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
    
    //MARK: GET/SET
    func getMovieArrayIndex() -> Movie{
        return arrayMovies[idMovieInArray]
    }
    
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
        return "⭐ \(nota)"
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
            
        case idGenres.terror.rawValue:
            return "\(nameGenres.terror.rawValue)"
            
        case idGenres.romance.rawValue:
            return "\(nameGenres.romance.rawValue)"
            
        case idGenres.war.rawValue:
            return "\(nameGenres.war.rawValue)"
            
        default:
            return "Indefinido"
        }
    }
    
    func addMovieArrayFavorites() {
        if arrayMovies.isEmpty{
            storageFirebase.saveMovie(movieData: movieSearchBar!, typeList: .favoritos)
        }else{
            storageFirebase.saveMovie(movieData: arrayMovies[idMovieInArray], typeList: .favoritos)
        }
    }
    
    func addMovieArraySeen() {
        if arrayMovies.isEmpty{
            storageFirebase.saveMovie(movieData: movieSearchBar!, typeList: .jaVistos)
        }else{
            storageFirebase.saveMovie(movieData: arrayMovies[idMovieInArray], typeList: .jaVistos)
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
        return dateFormatterPrint.string(from: date! as Date)
    }
    
    func showActivityIndicator(view: UIView){
        let text = "O filme certo; na hora certa. Conheça o Jeffrey \n O app que mostra o que há de melhor nos streamings!\n Olha só o que ele me indicou: \(getTitle())"
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        viewController?.present(viewController: activityViewController)
    }
}
