//
//  SelectedMovieViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 26/11/20.
//

import UIKit

protocol SelectedMovieViewModelProtocol: AnyObject{
    func getImageFilm() -> UIImage
    func setArrayMovies(arrayMovie: [Movie])
    func getOverView( ) -> String
    func getTitle() -> String
    func getRelease() -> String
    func getVoteAverage() -> String
    func addMovieArrayFavorites()
    func addMovieArraySeen()
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void)
    func setNameProvider(providerName: String)
}


class SelectedMovieViewModel:SelectedMovieViewModelProtocol{
    
    func raffleListOfAPIMovies(completion: @escaping (Bool) -> Void) {
        selectedMovieAPI.requestMovie { arrayMovies in
            
            
            self.setArrayMovies(arrayMovie: arrayMovies)
            
            
            completion(true)
            
            return
            
        }
    }
    
    func setNameProvider(providerName: String) {
        self.providerName = providerName
    }
    
    func getImageFilm() -> UIImage {
        let idImage =  arrauResultsAPI[idMovieInArray].posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
        
        let data = try? Data(contentsOf: url!)
        
        return  UIImage(data: data!)!
    }
    
    func setArrayMovies(arrayMovie: [Movie]) {
        arrauResultsAPI = arrayMovie
    }
    
    func getOverView() -> String {
        return arrauResultsAPI[idMovieInArray].overview
    }
    
    func getTitle() -> String {
        return arrauResultsAPI[idMovieInArray].title
    }
    
    func getRelease() -> String {
        return arrauResultsAPI[idMovieInArray].releaseDate
    }
    
    func getVoteAverage() -> String {
        let nota = arrauResultsAPI[idMovieInArray].voteAverage!
        //        return "\(nota) / 10 ⭐  "
        return "\(nota) ⭐"
    }
    
    func addMovieArrayFavorites() {
        arrayMovieFavorites.append(arrauResultsAPI[idMovieInArray])
    }
    
    func addMovieArraySeen() {
        arrayMovieSeen.append(arrauResultsAPI[idMovieInArray ])
        
    }
    
    
    //MARK: VARIÁVEIS
    
    private var arrauResultsAPI = [Movie]() // Onde será carregado a request da API
    var idMovieInArray = 0 // Indice do Filme no array de Filmes, é alterado cada vez que é sorteado um novo filme.
    private var idPageApi = 2 // Alterar a pagina na requisição da API
    private var genre = 28 // ID do gênero para a requisicão na API! Fixo 28 para testes! obs: Acão
    private var idProvider = 8
    private var providerName : String?
    var arrayMovieFavorites = [Movie]() // Lista Filmes Favorios
    var arrayMovieSeen = [Movie]() // Lista Filmes Já Vistos
    
    var selectedMovieAPI = SelectedMovieAPI()
    private var customSegmentedControll = CustomSegmentControl()
    
    
    
    
    func setButtonImageSeen(imageButton: UIImageView) -> UIImage {
        
        if imageButton.image == UIImage(systemName: "eye"){
            imageButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return UIImage(systemName: "eye.slash")!
        }else{
            
            imageButton.tintColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
            return UIImage(systemName: "eye")!
        }
    }
    //
    func setButtonImageFavorite(imageButton: UIImageView) -> UIImage{
        
        
        
        if imageButton.image == UIImage(systemName: "star"){
            imageButton.tintColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
            return UIImage(systemName: "star.fill")!
        }else{
            imageButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return UIImage(systemName: "star")!
        }
    }
    
    
    
    
    
    
//    func request( completion: @escaping (Bool) -> Void) {
//        
//        selectedMovieAPI.requestMovie { arrayMovies in
//            
//            self.setArrayMovies(arrayMovie: arrayMovies)
//            
//            self.addOneToId()
//            completion(true)
//            
//            return
//            
//        }
//        
//    }
    
    func newMovieInArray(){
        idMovieInArray += 1
        
    }
    
    private func newPageOfMovies() -> Bool{
        if self.idMovieInArray > 19 {
            self.arrauResultsAPI = [Movie]()
            self.idMovieInArray = 0
            self.idPageApi += 1
            return true
        }
        
        return false
    }
    //
    private func addOneToId(){
        
        idMovieInArray += 1
        
    }
    
    
    
    //MARK: PERGUNTA: Preciso receber como parametro a imagem que quero arredondar ou existe outra maneira?
    func roundImage(image:UIButton){
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        
        image.setImage(UIImage(named: "novofilme"), for: .normal)
        image.backgroundColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
        
        
    }
    
    func checkProvidersOfMovie( completion: @escaping (Bool) -> Void) {
        
        if let idMovie = arrauResultsAPI[idMovieInArray].id{
            selectedMovieAPI.checkProvaider(idMovie: idMovie) { arrayFlatrate in
                
                if self.providerSelected(provider: "Telecine Play", flatrates: arrayFlatrate){
                    completion(true)
                    return
                    
                    
                    
                }else{
                    
                    completion(false)
                    return
                    
                }
            }
        }
        completion(false)
        return
    }
    
    func sortear( completion: @escaping (Bool) -> Void){
        
        if arrauResultsAPI .isEmpty {
                        raffleListOfAPIMovies { sucess in
                
                completion(true)
                return
            }
        }else{
            newMovieInArray()
            checkProvidersOfMovie { sucess in
                if sucess{
                    print("\(self.arrauResultsAPI[self.idMovieInArray])hhahahahahahah tem")
                    completion(true)
                    return
                    
                }else{
                    
                }
                //                else{
                ////                    self.sortear { sucess in
                ////                        completion(true)
                ////                        return
                ////
                ////                    }
                //                }
            }
            
        }
    }
    
   
    
    func getImageStreaming() -> String{
        if let providerName = providerName{
            return providerName
        }
        return "star"
    }
    
    func providerSelected(provider: String, flatrates: [Flatrate]) -> Bool{
        setNameProvider(providerName: provider)
        for flatrate in flatrates{
            if flatrate.providerName == provider{
                print("esse filme esta na \(provider)")
                return true
            }
            
        }
        
        return false
        
    }
    
    
    
}


