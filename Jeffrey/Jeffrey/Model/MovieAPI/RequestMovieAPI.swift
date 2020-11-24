//
//  requestMovieAPI.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 18/11/20.
//

import Foundation
import Alamofire

class RequestMovieAPI{
      private var movie: Movie?
    
    private func requestMovie(id: Int)  {
        
        AF.request("https://api.themoviedb.org/3/movie/\(id)?api_key=16b776cd87d99568d7cf733de5593752&language=pt-BR").responseJSON { response in
            if let dictionary = response.value as? [String: Any] {
                let movie = Movie(fromDictionary: dictionary)
                DispatchQueue.main.async {
                    self.setMovie(movie: movie)
                }
                
                
            }
            
        }
        
        
       
    }
    func setMovie(movie: Movie)  {
        self.movie = movie
    }
    
    func getFilme(id:Int) -> Movie{
        
        requestMovie(id: id)
        return movie!
    }
}
