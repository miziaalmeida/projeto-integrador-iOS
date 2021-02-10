//
//  SearchViewModel.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit
import CoreData
import SearchTextField

protocol SearchViewModelProtocol: AnyObject{
    
    func getArrayCount() -> Int
    func getMovieInArray(index: Int) -> Movie
    func requestDataBase(context: NSManagedObjectContext, mySearchTextField: SearchTextField)
    func raffleListOfAPIMovies(textSearch: String ,completion: @escaping (Bool) -> Void)
    func saveMovie(context: NSManagedObjectContext, mySearchTextField: SearchTextField)
    var  viewController: SearchViewControllerEvents? { get set }
}

class SearchViewModel: SearchViewModelProtocol {
    
    weak var viewController: SearchViewControllerEvents?
    var movie: MovieData!
    var movieData = DataManager.shared
    var arraySearch = [String]()
    var arrayMovies = [Movie]()
    var apimanager =  APIManager()
    var activityIndicator = ActivityIndicatorViewController()

    
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
    
    func saveMovie(context: NSManagedObjectContext, mySearchTextField: SearchTextField) {
        let textSearch = mySearchTextField.text!.replacingOccurrences(of: " ", with: "+")
        if movie == nil {
            movie = MovieData(context: context)
        }
        
        movie.textSearch = mySearchTextField.text
        movie = nil
        
        let textReplace = textSearch.replacingOccurrences(of: "+", with: " ")
        if(!arraySearch.contains(textReplace)) {
            do{
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func requestDataBase(context: NSManagedObjectContext, mySearchTextField: SearchTextField){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "textSearch") as! String)
                arraySearch.append(data.value(forKey: "textSearch") as! String)
            }
            mySearchTextField.filterStrings(arraySearch)
        } catch {
            print("Failed")
        }
    }
}
