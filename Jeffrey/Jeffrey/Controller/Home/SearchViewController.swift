//
//  SearchViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 20/11/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableViewSearch: UITableView!
    var arraySearch = [Search]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSearch.delegate = self
        tableViewSearch.dataSource = self
        

    }
}

extension SearchViewController : UITableViewDelegate{
    
}
extension SearchViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewSearch.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.setup(search: arraySearch[indexPath.row])
        
        return cell
    }
    
    
}
