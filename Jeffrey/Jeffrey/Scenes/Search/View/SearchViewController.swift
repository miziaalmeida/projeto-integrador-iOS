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
    
    var viewModel : SearchViewModelProtocol!
    var movie = MovieData()
    var movieData = DataManager.shared
    var arraySearch = [String]()
    
    @IBAction func buttonSearchTitle(_ sender: UIButton) {
        
        let textSearch = mySearchTextField.text!.replacingOccurrences(of: " ", with: "+")
        try? context.save()
                viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
                    if sucess{
                        self.arraySearch.append(textSearch)
                        self.mySearchTextField.filterStrings(self.arraySearch)
                        self.table.delegate = self
                        self.table.dataSource = self
                        self.table.reloadData()
                    }
                }
    }

    
//    // MARK: PickerView
//    lazy var pickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerView.backgroundColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
//        pickerView.setValue(UIColor.white, forKeyPath: "textColor")
//        return pickerView
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //movieData.loadData(with: context)
        viewModel = SearchViewModel()
        setupSearchTexfield()
        
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
           
           mySearchTextField.itemSelectionHandler = { [self] filteredResults, itemPosition in
               // Just in case you need the item position
               let item = filteredResults[itemPosition]
               let textSearch = item.title.replacingOccurrences(of: " ", with: "+")
               //movieData.loadData(with: context)
               viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
                   if sucess{
                       self.table.delegate = self
                       self.table.dataSource = self
                       self.table.reloadData()
                   }
               }

               self.mySearchTextField.text = item.title
           }
           
       }
        //searchBar.delegate = self
//        loadMovies()
//
//        customSearch()
//        customToolbar()
        

        
        //        viewModel.raffle { (sucess) in
        //            if sucess{
        //                            self.table.delegate = self
        //                            self.table.dataSource = self
        //                            self.table.reloadData()
        //                        }
        //        }
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        pickerView.reloadAllComponents()
//    }
//
//    func loadMovies(){
//        movieData.loadData(with: context)
//        pickerView.reloadAllComponents()
//
//    }
//
//    @objc func cancel(){
//         searchBar.resignFirstResponder()
//    }
//
//    @objc func done(){
//        searchBar.text = movieData.moviesData[pickerView.selectedRow(inComponent: 0)].textSearch
//        cancel()
//    }
    
//
//    func customToolbar(){
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
//        toolbar.barTintColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
//
//        let buttonCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
//        buttonCancel.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        let buttonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        buttonDone.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        let buttonFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//
//        toolbar.items = [buttonCancel,buttonFlexibleSpace, buttonDone]
//        searchBar.inputAccessoryView = toolbar
//    }
//
//    func customSearch(){
//        searchBar.tintColor = .white
//        //searchBar.barTintColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
//
//        let textField = searchBar.value(forKey: "searchField") as? UITextField
//        textField?.textColor = UIColor.white
//        textField?.backgroundColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
//        textField?.layer.borderWidth = 1
//        textField?.layer.borderColor = UIColor.white.cgColor
//        textField?.layer.cornerRadius = 10
//        textField?.borderStyle = .none
//        textField?.inputView = pickerView
//
//
//
//
//
//        let glassIconView = textField?.leftView as! UIImageView
//        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
//        glassIconView.tintColor = UIColor.white
//
//        let clearButton = textField?.value(forKey: "clearButton") as! UIButton
//        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
//        clearButton.tintColor = UIColor.white
//    }
//extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return movieData.moviesData.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let movie = movieData.moviesData[row]
//        return movie.textSearch
//        }
//    }

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

//extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating{
//    func updateSearchResults(for searchController: UISearchController) {
//
//    }
//
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
//        let textSearch = searchBar.text!.replacingOccurrences(of: " ", with: " ")
//        try? context.save()
//        pickerView.reloadAllComponents()
//        viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
//            if sucess{
//                self.table.delegate = self
//                self.table.dataSource = self
//                self.table.reloadData()
//            }
//        }
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.table.reloadData()
//    }
//
//
//    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
//    //        var textSearch = searchText.replacingOccurrences(of: " ", with: "")
//    //        viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
//    //                        if sucess{
//    //                                        self.table.delegate = self
//    //                                        self.table.dataSource = self
//    //                                        self.table.reloadData()
//    //                                    }
//    //                    }
//    //    }
//}
//
//extension SearchViewController: NSFetchedResultsControllerDelegate{
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//        switch type{
//            case .delete:
//                break
//            default:
//                table.reloadData()
//            }
//    }
//}


