//
//  ListasViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var segmentedControlList: UISegmentedControl!
    @IBOutlet weak var tableViewList: UITableView!
    
    var customSegmentedControl = CustomSegmentControl()
    var arrayMovieFavorites : [Movie]?
    var arrayMovieSee : [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(SelectedMovieViewModel.arrayMovieFavorites.count)
        arrayMovieFavorites = SelectedMovieViewModel.arrayMovieFavorites
        arrayMovieSee = SelectedMovieViewModel.arrayMovieSeen
        tableViewList.reloadData()
        tableViewList.delegate = self
        tableViewList.dataSource = self

        tableViewList.reloadData()
        customSegmentedControl.segmentControlCustom(custom: segmentedControlList, view: view)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewList.reloadData()
    }

    @IBAction func segmentControlList(_ sender: UISegmentedControl) {
        
        customSegmentedControl.indexChangedSegmentControll(segmentedControll: segmentedControlList, view: view)
        print(segmentedControlList.selectedSegmentIndex)
        tableViewList.reloadData()
        
        
        }
}

extension ListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let storyboard = UIStoryboard(name: "SelectedMovie", bundle: nil);
            let vc = storyboard.instantiateViewController(withIdentifier: "SelectedMovie") as! SelectedMovieViewController; // MySecondSecreen the storyboard ID
            //        print("chegou o filme \(movie.title)")
            vc.raffle = false
            if segmentedControlList.selectedSegmentIndex == 0{
                vc.movieScreenHome = SelectedMovieViewModel.arrayMovieFavorites[indexPath.row]
            }else{
                vc.movieScreenHome = SelectedMovieViewModel.arrayMovieSeen[indexPath.row]
            }
            
            self.present(vc, animated: true, completion: nil);
        }
}

extension  ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControlList.selectedSegmentIndex == 0{
            if arrayMovieFavorites?.count != nil{
                return SelectedMovieViewModel.arrayMovieFavorites.count
            }else{
                return 0
            }
            
        }else{
            if arrayMovieSee?.count != nil{
                return SelectedMovieViewModel.arrayMovieSeen.count
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        if segmentedControlList.selectedSegmentIndex == 0{
            cell.setup(movie: SelectedMovieViewModel.arrayMovieFavorites[indexPath.row])
        }else{
            cell.setup(movie: SelectedMovieViewModel.arrayMovieSeen[indexPath.row])
        }
        
        let imageIndicator = UIImageView(image: UIImage(named:"icon-right-arrow"))
        cell.accessoryView = imageIndicator
        imageIndicator.tintColor = UIColor.yellow
        imageIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        
        return cell
        
        
    }
    
    
    
    
    
    
}


