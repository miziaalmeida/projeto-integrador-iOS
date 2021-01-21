//
//  SearchViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit
import CoreData


class SearchViewController: UIViewController {
    
    @IBOutlet var table:UITableView!
    @IBOutlet var searchBar:UISearchBar!
    
    var viewModel : SearchViewModelProtocol!
    
    var movieData = DataManager.shared

    
    // MARK: PickerView
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
        pickerView.setValue(UIColor.white, forKeyPath: "textColor")
        return pickerView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        
        searchBar.delegate = self
        loadMovies()
        
        customSearch()
        customToolbar()
        

        
        //        viewModel.raffle { (sucess) in
        //            if sucess{
        //                            self.table.delegate = self
        //                            self.table.dataSource = self
        //                            self.table.reloadData()
        //                        }
        //        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickerView.reloadAllComponents()
    }
    
    func loadMovies(){
        movieData.loadData(with: context)
        pickerView.reloadAllComponents()
        
    }
    
    @objc func cancel(){
         searchBar.resignFirstResponder()
    }
    
    @objc func done(){
        searchBar.text = movieData.moviesData[pickerView.selectedRow(inComponent: 0)].textSearch
        cancel()
    }
    
         
    func customToolbar(){
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.barTintColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
        
        let buttonCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        buttonCancel.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let buttonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        buttonDone.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let buttonFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [buttonCancel,buttonFlexibleSpace, buttonDone]
        searchBar.inputAccessoryView = toolbar
    }
    
    func customSearch(){
        searchBar.tintColor = .white
        searchBar.barTintColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
        
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.textColor = UIColor.white
        textField?.backgroundColor = #colorLiteral(red: 0.2137669921, green: 0.05644740909, blue: 0.2667113841, alpha: 1)
        textField?.layer.borderWidth = 1
        textField?.layer.borderColor = UIColor.white.cgColor
        textField?.layer.cornerRadius = 10
        textField?.borderStyle = .none
        textField?.inputView = pickerView

        
        

        
        let glassIconView = textField?.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = UIColor.white
        
        let clearButton = textField?.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
    }
    

        }

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return movieData.moviesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let movie = movieData.moviesData[row]
        return movie.textSearch
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

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        let textSearch = searchBar.text!.replacingOccurrences(of: " ", with: " ")
        try? context.save()
        pickerView.reloadAllComponents()
        viewModel.raffleListOfAPIMovies(textSearch: textSearch) { (sucess) in
            if sucess{
                self.table.delegate = self
                self.table.dataSource = self
                self.table.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.table.reloadData()
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

extension SearchViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type{
            case .delete:
                break
            default:
                table.reloadData()
            }
    }
}


