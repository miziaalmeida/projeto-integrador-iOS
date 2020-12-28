//
//  SelectedMovieAPI.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 01/12/20.
//

import Foundation
import Alamofire

class SelectedMovieAPI {
    
    private var genre = 28 // fixa gênero com id 28 (Ação)
    private var keyAPI = "16b776cd87d99568d7cf733de5593752" // chave API
    private var baseURLAPI = "https://api.themoviedb.org/3/discover/movie?api_key="
    private var arrauResultsAPI = [Movie]() // Onde será carregado a request da API
    private var idPageApi = 8 // Ida da pagia para fazer o requeste (Fixo por momento) obs: Padrão começa com id=1
    private var resultsProviderBR: ResultAPIProvider?
    private var flatrate: Flatrate?
    //    private var flatrate = [Flatrate]()
    
    // faz o requeste de uma lista de filmes, onde pode ser filtrado por id do genero, numero da página. obs: requisição de uma lista de 20 filmes por página
    func listOfFilms(idPage: Int, onComplete: @escaping ([Movie]) -> Void)  {
//                        idPageApi = Int.random(in: 1..<50) // altera a pagina que ira mostrar os filmes obs
        
        print("novo request")
        AF.request("\(baseURLAPI)\(keyAPI)&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(idPage)&with_genres=\(genre)").responseJSON { response in
            if let dictionary = response.value as? [String: Any], let arrayResults = dictionary["results"] as? [[String:Any]]{
                
                var  arrayMovie = [Movie]()
                for result in arrayResults{
                    
                    let resultValue = Movie(fromDictionary: result)
                    arrayMovie.append(resultValue)
                    
                }
                onComplete(arrayMovie)
                return
            }
            onComplete([])
        }
    }
    
    
    // Func que faz o request  para saber em quais streaming o filme está disponível.
    func getProviders(idMovie: Int, onComplete: @escaping ([Flatrate]) -> Void){
        
        // faz a requisição pelo id do filme.
        AF.request("https://api.themoviedb.org/3/movie/\(idMovie)/watch/providers?api_key=16b776cd87d99568d7cf733de5593752").responseJSON { response in
            // filtro para pegar apenas os filmes disponivel para assinantes das plataformas no Brasil, excluindo filmes para alugar ou comprar.
            if let dictionary = response.value as? [String: Any], let arrayResults = dictionary["results"] as? [String:Any] , let restultBrasil = arrayResults["BR"] as? [String: Any], let flatrate = restultBrasil["flatrate"] as? [[String: Any]] {
                
                var arrayFlatrare = [Flatrate]()
                
                //faz o append dos streaming no arrayFlatrate
                for i in flatrate{
                    let flatrete = Flatrate(fromDictionary: i)
                    arrayFlatrare.append(flatrete)
                }
                
                onComplete(arrayFlatrare)
                return
            }
        }
        onComplete([])
    }
}
