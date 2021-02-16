//
//  HomeViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit
import Kingfisher

protocol HomeViewControllerEvents: AnyObject{
    func push(viewController: UIViewController)
    func present(viewController: UIViewController)
}

class HomeViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableViewHome:UITableView!
    
    private var viewModel: HomeViewModelProtocol?
    var activity = ActivityIndicatorViewController()
    
    
    
    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestHomeViewModel()
        
        self.viewModel = HomeViewModel()
        self.viewModel?.viewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func requestHomeViewModel(){
        DispatchQueue.main.async {
            self.activity.showActivityIndicator(view: self.view, targetVC: self)
            self.viewModel!.raffleListOfAPIMovies(genre: idGenres.comedy.rawValue) { (sucess) in
                self.viewModel!.raffleListOfAPIMovies(genre: idGenres.action.rawValue) { (sucess) in
                    self.viewModel!.raffleListOfAPIMovies(genre: idGenres.animation.rawValue) { (sucess) in
                        self.viewModel!.raffleListOfAPIMovies(genre: idGenres.terror.rawValue) { (sucess) in
                            self.viewModel!.raffleListOfAPIMovies(genre: idGenres.drama.rawValue) { (sucess) in
                                self.viewModel!.raffleListOfAPIMovies(genre: idGenres.fantasy.rawValue) { (sucess) in
                                    self.viewModel!.raffleListOfAPIMovies(genre: idGenres.romance.rawValue) { (sucess) in
                                        self.viewModel!.raffleListOfAPIMovies(genre: idGenres.adventure.rawValue) { (sucess) in
                                            self.viewModel!.raffleListOfAPIMovies(genre: idGenres.sciencefiction.rawValue) { (sucess) in
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
                    }
                }
            }
        }
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
        let arrayTitleSection = ["Pra gargalhar um pouco","Para quebrar tudo","Adulto também assiste","Deixa a luz acesa","Para chorar","Para toda a família","Para assistir juntos","Para se aventurar", "Para se desconectar"]
        
        return arrayTitleSection[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
        
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
        
        cell.numberOfIten = 20
        
        switch indexPath.section {
        case 0:
            cell.arrayMovies = viewModel!.getArrayComedy()
            cell.genre = nameGenres.comedy.rawValue
        case 1:
            cell.arrayMovies = viewModel!.getArrayAction()
            cell.genre = nameGenres.action.rawValue
        case 2:
            cell.arrayMovies = viewModel!.getArrayAnimation()
            cell.genre = nameGenres.animation.rawValue
        case 3:
            cell.arrayMovies = viewModel!.getArrayTerror()
            cell.genre = nameGenres.terror.rawValue
        case 4:
            cell.arrayMovies = viewModel!.getArrayDrama()
            cell.genre = nameGenres.drama.rawValue
        case 5:
            cell.arrayMovies = viewModel!.getArrayFantasy()
            cell.genre = nameGenres.fantasy.rawValue
        case 6:
            cell.arrayMovies = viewModel!.getArrayRomance()
            cell.genre = nameGenres.romance.rawValue
        case 7:
            cell.arrayMovies = viewModel!.getArrayAdventure()
            cell.genre = nameGenres.adventure.rawValue
        case 8:
            cell.arrayMovies = viewModel!.getArraySciencefiction()
            cell.genre = nameGenres.sciencefiction.rawValue
        default:
            print("Próximos generos")
        }
        
        cell.controller = self
        cell.sectionInTableView = indexPath.section
        
        cell.collectionViewHome.reloadData()
        
        
        return cell
    }
}
extension HomeViewController: HomeViewControllerEvents{
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
