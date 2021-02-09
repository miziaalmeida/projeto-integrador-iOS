//
//  SearchViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit
import CoreData
import SearchTextField

protocol SearchViewControllerEvents: AnyObject{
    func push(viewController: UIViewController)
    func present(viewController: UIViewController)
}

class SearchViewController: UIViewController{
    
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var mySearchTextField: SearchTextField!
    @IBOutlet weak var buttonSearch: UIButton!
    
    var activity = ActivityIndicatorViewController()
    var viewModel : SearchViewModelProtocol?
    var movie: MovieData!
    var movieData = DataManager.shared
    var arraySearch = [String]()
    
    @IBAction func buttonSearchTitle(_ sender: UIButton) {
        mySearchTextField.endEditing(true)
        let textSearch = mySearchTextField.text!.replacingOccurrences(of: " ", with: "+")
        viewModel?.saveMovie(context: context, mySearchTextField: mySearchTextField)
        getFilms(textSearch: textSearch)
    }
    
    
    func getFilms(textSearch: String) {
        activity.showActivityIndicator(view: view, targetVC: self)
        viewModel!.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
            if sucess{
                self.table.delegate = self
                self.table.dataSource = self
                self.table.reloadData()
                self.activity.hideActivityIndicator(view: self.view)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SearchViewModel()
        self.viewModel?.viewController = self
        setupSearchTexfield()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieData.loadMovies(with: context)
    }
    func setupSearchTexfield(){
        buttonSearch.addBorder(edge: .top, color: .white, thickness: 1.5)
        buttonSearch.addBorder(edge: .bottom , color: .white, thickness: 1.5)
        buttonSearch.addBorder(edge: .right, color: .white, thickness: 1.5)
        mySearchTextField.addBorder(edge: .top, color: .white, thickness: 1.5)
        mySearchTextField.addBorder(edge: .bottom , color: .white, thickness: 1.5)
        mySearchTextField.addBorder(edge: .left, color: .white, thickness: 1.5)
        mySearchTextField.maxNumberOfResults  =  10
        mySearchTextField.startVisible  =  true
        mySearchTextField.theme  = SearchTextFieldTheme.darkTheme ()
        mySearchTextField.theme.font = UIFont.systemFont(ofSize: 16)
        mySearchTextField.theme.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mySearchTextField.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        mySearchTextField.theme.bgColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)
        
        viewModel?.requestDataBase(context: context, mySearchTextField: mySearchTextField)
    }
}

extension SearchViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "SelectedMovie", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectedMovie") as! SelectedMovieViewController; //
        vc.raffle = false
        vc.movieScreenHome = viewModel!.getMovieInArray(index: indexPath.row)
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.getArrayCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let movie: Movie =  viewModel!.getMovieInArray(index: indexPath.row)
        
        cell.setup(movie: movie)
        let imageIndicator = UIImageView(image: UIImage(named:"icon-right-arrow"))
        cell.accessoryView = imageIndicator
        imageIndicator.tintColor = UIColor.yellow
        imageIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        return cell
        
    }
}
extension SearchViewController: SearchViewControllerEvents{
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}


