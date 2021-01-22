//
//  SearchViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit
import CoreData
import SearchTextField


class SearchViewController: UIViewController {
    
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var mySearchTextField: SearchTextField!
    @IBOutlet weak var buttonSearch: UIButton!
    
    var viewModel : SearchViewModelProtocol!
    var movie: MovieData!
    var movieData = DataManager.shared
    var arraySearch = [String]()
    
    @IBAction func buttonSearchTitle(_ sender: UIButton) {
        
        if movie == nil {
            movie = MovieData(context: context)
        }
        let textSearch = mySearchTextField.text!.replacingOccurrences(of: " ", with: "+")
        let text = mySearchTextField.text
        movie.textSearch = text
        
        do{
            try context.save()
            loadMovies()
        } catch {
            print(error.localizedDescription)
        }
        viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
            if sucess{
                self.arraySearch.append(self.mySearchTextField.text!)
                self.mySearchTextField.filterStrings(self.arraySearch)
                self.table.delegate = self
                self.table.dataSource = self
                self.table.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadMovies()
        setupSearchTexfield()
        viewModel = SearchViewModel()
        
        buttonSearch.layer.borderWidth = 1.5
        buttonSearch.layer.cornerRadius = 10
        buttonSearch.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieData.loadMovies(with: context)
    }
    
    func loadMovies(){
        movieData.loadMovies(with: context)
    }
    
    func setupSearchTexfield(){
        mySearchTextField.layer.borderWidth = 1.5
        mySearchTextField.layer.cornerRadius = 8
        mySearchTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mySearchTextField.filterStrings(arraySearch)
        mySearchTextField.maxNumberOfResults  =  10
        mySearchTextField.startVisible  =  true
        mySearchTextField.theme  = SearchTextFieldTheme.darkTheme ()
        mySearchTextField.theme.font = UIFont.systemFont(ofSize: 16)
        mySearchTextField.theme.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mySearchTextField.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        mySearchTextField.theme.bgColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        
        var array:[String] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "textSearch") as! String)
                array.append(data.value(forKey: "textSearch") as! String)
            }
            mySearchTextField.filterStrings(array)
            arraySearch = array
        } catch {
            print("Failed")
        }
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
        let movie: Movie =  viewModel.getMovieInArray(index: indexPath.row)
        
        cell.setup(movie: movie)
        
        return cell
        
    }
}
