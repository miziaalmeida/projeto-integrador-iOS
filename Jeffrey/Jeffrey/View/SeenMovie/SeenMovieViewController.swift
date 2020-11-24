//
//  SeenMovieViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 22/11/20.
//

import UIKit

class SeenMovieViewController: UIViewController {
    
    var whichListToDisplay = "favorite"
    
    
    
    @IBOutlet var tableViewSeen: UITableView!
    
    
    
    var controller = SeenMoviesController()

    var arraymovieFavorites = [Movie]()
    var arraymovieSeen = [Movie]()
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        if whichListToDisplay == "favorite"{
            title = "Lista de Favoritos"
        }else{
            title = "Lista de Já Vistos"
        }
        
        
        // arredonda botoões
        
        tableViewSeen.delegate = self
        tableViewSeen.dataSource = self
        tableViewSeen.reloadData()
        
    }
    

   

}
extension SeenMovieViewController: UITableViewDelegate {



}

extension SeenMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if whichListToDisplay == "favorite"{
            return arraymovieFavorites.count
        }else{
            return arraymovieSeen.count
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeenMoviewTableViewCell", for: indexPath) as! SeenMoviewTableViewCell
//
        if whichListToDisplay == "favorite"{
            cell.setup(movie: arraymovieFavorites[indexPath.row])
        }else{
            cell.setup(movie: arraymovieSeen[indexPath.row])
        }
        
        
        return cell
    }
    
    
}
