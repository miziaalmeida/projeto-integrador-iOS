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
   

}

class HomeViewModel:HomeViewModelProtocol{
    
    
    
    let apimanager = APIManager()
    
    var arrayMoviesComedy = [Movie]()
    var arrayMoviesAction = [Movie]()
    var arrayMoviesAnimation = [Movie]()
    var arrayMoviesTerror = [Movie]()
    
    func raffleListOfAPIMovies(genre: Int ,completion: @escaping (Bool) -> Void) {
        
        apimanager.listOfFilmswithoutProvider(idPage: 1, genre: genre) { (arraymovie) in
            
            if genre == 35 {
                self.arrayMoviesComedy = arraymovie
            }
            if genre == 28 {
                self.arrayMoviesAction = arraymovie
            }
            if genre == 16 {
                self.arrayMoviesAnimation = arraymovie
            }
            if genre == 27 {
                self.arrayMoviesTerror = arraymovie
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
    
 
    
    
  
    
    //sem utilizar no momento
  
            
        

}



