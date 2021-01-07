//
//  HomeViewModel.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 26/12/20.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject{
    
    func raffleListOfAPIMovies(textSearch: String ,completion: @escaping (Bool) -> Void)
   

}

class HomeViewModel:HomeViewModelProtocol{
    
    let apimanager = SelectedMovieAPI()
    
    var arrayMoviesComedy = [Movie]()
    
    func raffleListOfAPIMovies(textSearch: String ,completion: @escaping (Bool) -> Void) {
        
        apimanager.listOfFilmswithoutProvider(idPage: 1, genre: 16) { (arrayMovieComedy) in
            
            for movie in arrayMovieComedy{
                arrayMoviesComedy.append(Movie(fromDictionary: movie))
            }
            completion(true)
            return
        }
        
        
    
    
}

}

