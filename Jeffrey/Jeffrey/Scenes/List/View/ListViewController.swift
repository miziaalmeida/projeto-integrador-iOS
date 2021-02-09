//
//  ListasViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol ListViewControllerEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class ListViewController: UIViewController {
    
    @IBOutlet weak var segmentedControlList: UISegmentedControl!
    @IBOutlet weak var tableViewList: UITableView!
    
    private var viewModel: ListViewModelProtocol?
    var customSegmentedControl = CustomSegmentedControl()
    var arrayMovieFavorites = [Movie]()
    var arrayMovieSeen = [Movie]()
    var storageFirebase = FirebaseRealtime()
    var activityIndicator = ActivityIndicatorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showStorageFirebase()
        showCustomSegmentedControl()
        
        tableViewList.delegate = self
        tableViewList.dataSource = self
        tableViewList.reloadData()
        
        self.viewModel = ListViewModel()
        self.viewModel?.viewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewList.reloadData()
    }
    
    @IBAction func segmentControlList(_ sender: UISegmentedControl) {
        customSegmentedControl.indexChangedSegmentedControl(segmentedControl: segmentedControlList, view: view)
        print(segmentedControlList.selectedSegmentIndex)
        tableViewList.reloadData()
    }
    
    func showStorageFirebase(){
        activityIndicator.showActivityIndicator(view: view, targetVC: self)
        storageFirebase.listMovie(typeList: .favoritos) { (result) in
            self.arrayMovieFavorites.append(result)
            self.tableViewList.reloadData()
            self.activityIndicator.hideActivityIndicator(view: self.view)
        }
        activityIndicator.showActivityIndicator(view: view, targetVC: self)
        storageFirebase.listMovie(typeList: .jaVistos) { (result) in
            self.arrayMovieSeen.append(result)
            self.tableViewList.reloadData()
            self.activityIndicator.hideActivityIndicator(view: self.view)
        }
    }
    
    func showCustomSegmentedControl(){
        customSegmentedControl.segmentedControlCustom(custom: segmentedControlList, view: view)
    }
}

extension ListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedMovieView = UIStoryboard(name: "SelectedMovie", bundle: nil).instantiateViewController(withIdentifier: "SelectedMovie") as? SelectedMovieViewController
        else { return }
        
        selectedMovieView.raffle = false
        if segmentedControlList.selectedSegmentIndex == 0{
            selectedMovieView.movieScreenHome = arrayMovieFavorites[indexPath.row]
        }else{
            selectedMovieView.movieScreenHome = arrayMovieSeen[indexPath.row]
        }
        
        self.present(selectedMovieView, animated: true, completion: nil);
    }
}

extension  ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControlList.selectedSegmentIndex == 0{
            if arrayMovieFavorites.count > 0{
                return arrayMovieFavorites.count
            }else{
                return 0
            }
            
        }else{
            if arrayMovieSeen.count > 0{
                return arrayMovieSeen.count
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        if segmentedControlList.selectedSegmentIndex == 0{
            cell.setup(movie: arrayMovieFavorites[indexPath.row])
        }else{
            cell.setup(movie: arrayMovieSeen[indexPath.row])
        }
        
        let imageIndicator = UIImageView(image: UIImage(named:"icon-right-arrow"))
        cell.accessoryView = imageIndicator
        imageIndicator.tintColor = UIColor.yellow
        imageIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return cell
    
    }
}

extension ListViewController: ListViewControllerEvents{
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

