//
//  HomeViewModel.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 26/12/20.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject{
    
    func raffleListOfAPIMovies(genre: Int ,completion: @escaping (Bool) -> Void)
    func getCountArray() -> Int
 
    func getArrayComedy() -> [Movie]
    func getArrayAction() -> [Movie]
    func getArrayAnimation() -> [Movie]
    func getArrayTerror() -> [Movie]
    func getArrayRomance() -> [Movie]
    func getArrayFantasy() -> [Movie]
    
   

}

class HomeViewModel:HomeViewModelProtocol{
    
    
    
    let apimanager = APIManager()
    
    var arrayMoviesComedy = [Movie]()
    var arrayMoviesAction = [Movie]()
    var arrayMoviesAnimation = [Movie]()
    var arrayMoviesTerror = [Movie]()
    var arrayMoviesRomance = [Movie]()
    var arrayMoviesFantasy = [Movie]()
    
    func raffleListOfAPIMovies(genre: Int ,completion: @escaping (Bool) -> Void) {
        
        apimanager.listOfFilmswithoutProvider(idPage: 1, genre: genre) { (arraymovie) in
            
            if genre == idGenres.comedy.rawValue {
                self.arrayMoviesComedy = arraymovie
            }
            if genre == idGenres.action.rawValue {
                self.arrayMoviesAction = arraymovie
            }
            if genre == idGenres.animation.rawValue {
                self.arrayMoviesAnimation = arraymovie
            }
            if genre == idGenres.terror.rawValue {
                self.arrayMoviesTerror = arraymovie
            }
            if genre == idGenres.romance.rawValue {
                self.arrayMoviesRomance = arraymovie
            }
            if genre == idGenres.fantasy.rawValue {
                self.arrayMoviesFantasy = arraymovie
            }
            
            completion(true)
            return
        }
        
}
    func getCountArray() -> Int{
        
        return arrayMoviesComedy.count
    }
    
    func getArrayComedy() -> [Movie]{
        
        return arrayMoviesComedy
    }
    
    func getArrayAction() -> [Movie]{
        
        return arrayMoviesAction
    }
    
    func getArrayAnimation() -> [Movie]{
        
        return arrayMoviesAnimation
    }
    
    func getArrayTerror() -> [Movie]{
        
        return arrayMoviesTerror
    }
    
    func getArrayRomance() -> [Movie]{
        
        return arrayMoviesRomance
    }
    
    func getArrayFantasy() -> [Movie]{
        
        return arrayMoviesFantasy
    }
    
 
    
    
  
    
    //sem utilizar no momento
  
            
        

}



