//
//  SearchViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit

protocol SearchViewModelProtocol: AnyObject{
    
    func getArrayCount() -> Int
    func getMovieInArray(index: Int) -> Movie
    func raffleListOfAPIMovies(textSearch: String ,completion: @escaping (Bool) -> Void)
}

class SearchViewModel: SearchViewModelProtocol {
    
    private var arrayMovies = [Movie]()
    
    var apimanager =  APIManager()
    
    func getArrayCount() -> Int{
        return arrayMovies.count
    }
    
    func raffleListOfAPIMovies(textSearch: String ,completion: @escaping (Bool) -> Void) {
        apimanager.getMovieSearch(textSearch: textSearch, onComplete: { (arraySearch) in
            self.arrayMovies = arraySearch
            completion(true)
            return
        })
    }
    
    func getMovieInArray(index: Int) -> Movie{
        return arrayMovies[index]
    }
}
