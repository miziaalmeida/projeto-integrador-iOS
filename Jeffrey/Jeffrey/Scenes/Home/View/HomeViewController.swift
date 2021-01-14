//
//  HomeViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit
import Kingfisher

//protocol HomeViewControllerProtocol: AnyObject{
//    
//    func openopenScreenMovieDetail(indexSectionTableView:Int, indexMovie: Int)
//
//}

class HomeViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    // MARK: - Outlets
    
    @IBOutlet weak var tableViewHome:UITableView!
    
    var viewModel: HomeViewModelProtocol!

    var activity = ActivityIndicatorViewController()
    
    

    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        
        activity.showActivityIndicator(view: view, targetVC: self)
                viewModel.raffleListOfAPIMovies(genre: 35) { (sucess) in
                    self.viewModel.raffleListOfAPIMovies(genre: 28) { (sucess) in
                        self.viewModel.raffleListOfAPIMovies(genre: 16) { (sucess) in
                            self.viewModel.raffleListOfAPIMovies(genre: 27) { (sucess) in
                                self.activity.hideActivityIndicator(view: self.view)
                                self.tableViewHome.delegate = self
                                self.tableViewHome.dataSource = self
                                self.tableViewHome.reloadData()
                            }
                            
                        }
                       
                    }
                    
                }
        tableViewHome.estimatedRowHeight = 85.0
        tableViewHome.rowHeight = UITableView.automaticDimension
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func openopenScreenMovieDetail(movie:Movie){
//
//        
//        
        let storyboard = UIStoryboard(name: "SelectedMovie", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectedMovie") as! SelectedMovieViewController;
        vc.raffle = false
        vc.movieScreenHome = movie
        self.present(vc, animated: true, completion: nil);
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let tableHeader = view as! UITableViewHeaderFooterView
              tableHeader.tintColor = UIColor.clear
              tableHeader.textLabel?.textColor = .white
              tableHeader.textLabel?.font = UIFont(name: "Helvetica-Neue", size: 25)
              tableHeader.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            
            return 40
        }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Comédia"
        case 1:
            return "Ação"
        case 2:
            return "Animação"
        case 3:
            return "Terror"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 4

        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if(indexPath.section == 0 ){
            return 400
        }else{
            return 200
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! HomeTableViewCell
//        cell.numberOfIten = viewModel.getCountArray()
        cell.numberOfIten = 20
        switch indexPath.section {
        case 0:
            cell.arrayMovies = viewModel.getArrayComedy()
            cell.genre = "Comédia"
        case 1:
            cell.arrayMovies = viewModel.getArrayAction()
            cell.genre = "Ação"
        case 2:
            cell.arrayMovies = viewModel.getArrayAnimation()
            cell.genre = "Animação"
        case 3:
            cell.arrayMovies = viewModel.getArrayTerror()
            cell.genre = "Terror"
        default:
            ""
        }
        
        cell.controller = self
        cell.sectionInTableView = indexPath.section

        return cell
    }
}

// MARK: - Extensions
//extension HomeViewController : UITableViewDelegate{
//
//}
//extension HomeViewController  : UITableViewDataSource{
//
    
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return imageURL.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
        
//}
//
//extension HomeViewController : UICollectionViewDelegate{
//
//}
//extension HomeViewController : UICollectionViewDataSource{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageURL.count
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let  collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
//        collectionCell.layer.cornerRadius = 10
//        collectionCell.layer.masksToBounds = true
//        let imageView = UIImageView()
//        collectionCell.addSubview(imageView)
//        imageView.backgroundColor = .lightGray
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.leadingAnchor.constraint(equalTo: collectionCell.leadingAnchor, constant: 5).isActive = true
//        imageView.trailingAnchor.constraint(equalTo: collectionCell.trailingAnchor, constant: -5).isActive = true
//        imageView.topAnchor.constraint(equalTo: collectionCell.topAnchor, constant: 5).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: collectionCell.bottomAnchor, constant: 5).isActive = true
//
//
//        imageView.kf.setImage(with: URL(string: imageURL[indexPath.row]))
//
//        return collectionCell
//    }
//
//
//}
//extension HomeViewController: UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        if(indexPath.section == 0){
//            return CGSize(width: 150, height: 300)
//        } else {
//            return CGSize(width: 100, height: 100)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout
//                            collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//}
