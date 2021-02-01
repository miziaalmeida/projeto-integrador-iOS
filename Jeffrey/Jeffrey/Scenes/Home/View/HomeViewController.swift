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
        viewModel.raffleListOfAPIMovies(genre: idGenres.comedy.rawValue) { (sucess) in
            self.viewModel.raffleListOfAPIMovies(genre: idGenres.action.rawValue) { (sucess) in
                self.viewModel.raffleListOfAPIMovies(genre: idGenres.animation.rawValue) { (sucess) in
                    self.viewModel.raffleListOfAPIMovies(genre: idGenres.terror.rawValue) { (sucess) in
                        self.viewModel.raffleListOfAPIMovies(genre: idGenres.romance.rawValue) { (sucess) in
                            self.viewModel.raffleListOfAPIMovies(genre: idGenres.fantasy.rawValue) { (sucess) in


                                self.activity.hideActivityIndicator(view: self.view)
                                self.tableViewHome.delegate = self
                                self.tableViewHome.dataSource = self
                                self.tableViewHome.reloadData()
                            }
                        }

                    }

                }
            }

        }
        //        tableViewHome.estimatedRowHeight = 85.0
        //        tableViewHome.rowHeight = UITableView.automaticDimension

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func openopenScreenMovieDetail(movie:Movie){
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
        let arrayTitleSection = ["Pra gargalhar um pouco ..","Para quebrar tudo..","Adulto também assiste ..","Deixa a luz acesa.","Pra curtir a dois","Pra toda a família"]

        return arrayTitleSection[section]
        //        switch section {
        //        case 0:
        //            return "Comédia"
        //        case 1:
        //            return "Ação"
        //        case 2:
        //            return "Animação"
        //        case 3:
        //            return "Terror"
        //        default:
        //            return ""
        //        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if(indexPath.section == 0){
            return 350
        }else{
            return 175
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! HomeTableViewCell
        //        cell.numberOfIten = viewModel.getCountArray()
        cell.numberOfIten = 20
        switch indexPath.section {
        case 0:
            cell.arrayMovies = viewModel.getArrayComedy()
            cell.genre = nameGenres.comedy.rawValue
        case 1:
            cell.arrayMovies = viewModel.getArrayAction()
            cell.genre = nameGenres.action.rawValue
        case 2:
            cell.arrayMovies = viewModel.getArrayAnimation()
            cell.genre = nameGenres.animation.rawValue
        case 3:
            cell.arrayMovies = viewModel.getArrayTerror()
            cell.genre = nameGenres.terror.rawValue
        case 4:
            cell.arrayMovies = viewModel.getArrayRomance()
            cell.genre = nameGenres.romance.rawValue
        case 5:
            cell.arrayMovies = viewModel.getArrayFantasy()
            cell.genre = nameGenres.fantasy.rawValue
        default:
            print("Próximos generos")
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
