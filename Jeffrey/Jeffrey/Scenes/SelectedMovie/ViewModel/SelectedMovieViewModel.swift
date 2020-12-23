//
//  SelectedMovieViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 26/11/20.
//

import UIKit
//import Alamofire

class SelectedMovieViewModel{
    
    
    //MARK: VARIÁVEIS
    
    private var arrauResultsAPI = [Movie]() // Onde será carregado a request da API
    private var idMovieInArray = 0 // Indice do Filme no array de Filmes, é alterado cada vez que é sorteado um novo filme.
    private var idPageApi = 1 // Alterar a pagina na requisição da API
    private var genre = 28 // ID do gênero para a requisicão na API! Fixo 28 para testes! obs: Acão
    private var idProvider = 8
    private var providerName : String?
    var arrayMovieFavorites = [Movie]() // Lista Filmes Favorios
    var arrayMovieSeen = [Movie]() // Lista Filmes Já Vistos
    
    var selectedMovieAPI = SelectedMovieAPI()
    
    private var customSegmentedControll = CustomSegmentControl()
    
    //MARK: FUNCÕES PRIVADAS
    
    
    
    func getImageFilm() -> UIImage{
        let idImage =  arrauResultsAPI[idMovieInArray].posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
        
        let data = try? Data(contentsOf: url!)
        
        return  UIImage(data: data!)!
    }
    
    //MARK: FUNCÕES PÚBLICAS
    
    private  func setArrayMovies(arrayMovie: [Movie]){
        arrauResultsAPI = arrayMovie
    }
    
    func getOverView( ) -> String{
        return arrauResultsAPI[idMovieInArray].overview
    }
    
    func getTitle() -> String{
//        print(arrauResultsAPI[idMovieInArray].id)x`
        return arrauResultsAPI[idMovieInArray].title
        
    }
    
    
    func getRelease() -> String{
        return arrauResultsAPI[idMovieInArray].releaseDate
    }
    
    func getVoteAverage() -> String{
        let nota = arrauResultsAPI[idMovieInArray].voteAverage!
//        return "\(nota) / 10 ⭐  "
        return "\(nota) ⭐"
    }
    
    func addMovieArrayFavorites(){
        arrayMovieFavorites.append(arrauResultsAPI[idMovieInArray - 1])
    }
    
    func addMovieArraySeen(){
        arrayMovieSeen.append(arrauResultsAPI[idMovieInArray - 1 ])
    }
    
    func setButtonImageSeen(imageButton: UIImageView) -> UIImage {
        
        if imageButton.image == UIImage(systemName: "eye"){
            imageButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return UIImage(systemName: "eye.slash")!
        }else{
            
            imageButton.tintColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
            return UIImage(systemName: "eye")!
        }
    }
    
    func setButtonImageFavorite(imageButton: UIImageView) -> UIImage{
        
        
        
        if imageButton.image == UIImage(systemName: "star"){
            imageButton.tintColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
            return UIImage(systemName: "star.fill")!
        }else{
            imageButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return UIImage(systemName: "star")!
        }
    }
    
    // MARK: Request
    
    func request( completion: @escaping (Bool) -> Void) {
        if arrauResultsAPI.isEmpty{
            selectedMovieAPI.requestMovie { arrayMovies in
                
                
                self.setArrayMovies(arrayMovie: arrayMovies)
              
                self.addOneToId()
                completion(true)
                
                return
                
            }
            
        }else{
         
            
            self.addOneToId()
            
            if self.newPageOfMovies() {
                completion(false)
                return
            }
            
            completion(true)
            
            return
        }
        
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
    
    private func addOneToId(){
        
        idMovieInArray += 1
        
    }
    
    
    
    //MARK: PERGUNTA: Preciso receber como parametro a imagem que quero arredondar ou existe outra maneira?
    func roundImage(image:UIImageView){
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    
    func checkProvidersOfMovie( completion: @escaping (Bool) -> Void) {
 
        if let idMovie = arrauResultsAPI[idMovieInArray].id{
            selectedMovieAPI.checkProvaider(idMovie: idMovie) { arrayFlatrate in
                if !arrayFlatrate.isEmpty{
                    if self.providerSelected(provider: "Telecine Play", flatrates: arrayFlatrate){
                        completion(true)
                        return
                    }
                    
                
                }
            }
        }
    }
    
    private func setNameProvider(providerName: String){
        self.providerName = providerName
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


