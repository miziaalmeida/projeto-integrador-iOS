//
//  HomeViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 20/11/20.
//

import UIKit


class HomeViewController: UIViewController{
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableViewList: UITableView!

    @IBOutlet weak var labelName: UILabel!

    
    var arrayMovies = [Movie]()
   // var arrayMovies = [Series]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableViewList.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableViewList.delegate = self
        tableViewList.dataSource = self
        self.tableViewList.separatorStyle = UITableViewCell.SeparatorStyle.none

        
           arrayMovies.append(Movie(myImage: "csi"))
           arrayMovies.append(Movie(myImage: "bly"))
           arrayMovies.append(Movie(myImage: "eapeac"))
           arrayMovies.append(Movie(myImage: "fear"))
           arrayMovies.append(Movie(myImage: "mlnp"))
           arrayMovies.append(Movie(myImage: "simpson"))
            arrayMovies.append(Movie(myImage: "csi"))
            arrayMovies.append(Movie(myImage: "bly"))
            arrayMovies.append(Movie(myImage: "eapeac"))
            arrayMovies.append(Movie(myImage: "fear"))
            arrayMovies.append(Movie(myImage: "mlnp"))
            arrayMovies.append(Movie(myImage: "simpson"))
            arrayMovies.append(Movie(myImage: "csi"))
            arrayMovies.append(Movie(myImage: "bly"))
            arrayMovies.append(Movie(myImage: "eapeac"))
            arrayMovies.append(Movie(myImage: "fear"))
            arrayMovies.append(Movie(myImage: "mlnp"))
            arrayMovies.append(Movie(myImage: "simpson"))

        
    }

    
}

extension HomeViewController: UITableViewDelegate{
    
}
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if segmentControl.selectedSegmentIndex == 0{
//            return arrayMovies.conunt
//        } else if segmentControl.selectedSegmentIndex == 0{
//            return arraySeries.count
//        }
        return arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewList.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configure(with: arrayMovies)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
                    return 400.0

        } else{
            return 200.0
    }
}

}
