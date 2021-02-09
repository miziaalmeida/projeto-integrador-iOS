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
    
    var activity = ActivityIndicatorViewController()
    var viewModel : SearchViewModelProtocol!
    var movie: MovieData!
    var movieData = DataManager.shared
    var arraySearch = [String]()
    
    @IBAction func buttonSearchTitle(_ sender: UIButton) {
        mySearchTextField.endEditing(true)
        let textSearch = mySearchTextField.text!.replacingOccurrences(of: " ", with: "+")
        saveMovie(textSearch: textSearch)
        getFilms(textSearch: textSearch)
    }
    
    func saveMovie(textSearch: String) {
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
        
        viewModel = SearchViewModel()
        setupSearchTexfield()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieData.loadMovies(with: context)
    }
    
    func loadMovies(){
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
        
        requestDataBase()
        //deleteDataBase()

    }
    
    func requestDataBase(){
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
    
    func deleteDataBase(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        request.returnsObjectsAsFaults = false
        do {
            let arrUsrObj = try context.fetch(request)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                context.delete(usrObj)
            }
            try context.save() //don't forget
        } catch let error as NSError {
            print("delete fail--",error)
            
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
        let imageIndicator = UIImageView(image: UIImage(named:"icon-right-arrow"))
        cell.accessoryView = imageIndicator
        imageIndicator.tintColor = UIColor.yellow
        imageIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        return cell
        
    }
}

extension UIView {

func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

    let border = CALayer()

    switch edge {
    case .top:
        border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
        break
    case .bottom:
        border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
        break
    case .left:
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
        break
    case .right:
        border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
        break
    default:
        break
    }
   
    border.backgroundColor = color.cgColor

    layer.addSublayer(border)
}
}
