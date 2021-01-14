//
//  SearchViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var table:UITableView!
    @IBOutlet var searchBar:UISearchBar!
    
    var viewModel : SearchViewModelProtocol!
    var activityIndicator = ActivityIndicatorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        
        
        searchBar.delegate = self
        
        
        
        
        
        //        viewModel.raffle { (sucess) in
        //            if sucess{
        //                            self.table.delegate = self
        //                            self.table.dataSource = self
        //                            self.table.reloadData()
        //                        }
        //        }
        
    }
    
    
    
    
    
    
}

extension SearchViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let storyboard = UIStoryboard(name: "SelectedMovie", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectedMovie") as! SelectedMovieViewController; // MySecondSecreen the storyboard ID
        //        print("chegou o filme \(movie.title)")
        vc.raffle = false
        vc.movieScreenHome = viewModel.getMovieInArray(index: indexPath.row)
        self.present(vc, animated: true, completion: nil);
    }
    
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        let movie:Movie = viewModel.getMovieInArray(index: indexPath.row)
        
        cell.setup(movie: movie)
        
        return cell
        
        
    }
    
    
}

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.tintColor = UIColor.white
        let textSearch = searchBar.text!.replacingOccurrences(of: " ", with: "+")
        print(textSearch)
        activityIndicator.showActivityIndicator(view: view, targetVC: self)
        viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
            if sucess{
                self.table.delegate = self
                self.table.dataSource = self
                self.table.reloadData()
                self.activityIndicator.hideActivityIndicator(view: self.view)
            }
        }
    }
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    //        var textSearch = searchText.replacingOccurrences(of: " ", with: "")
    //        viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
    //                        if sucess{
    //                                        self.table.delegate = self
    //                                        self.table.dataSource = self
    //                                        self.table.reloadData()
    //                                    }
    //                    }
    //    }
}


