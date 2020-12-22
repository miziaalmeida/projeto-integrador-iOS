//
//  HomeViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit
import Kingfisher



class HomeViewController: UIViewController {
    
    let model:[[UIColor]] = generateRandomData()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableViewHome:UITableView!
    
    
    
    
    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
       
        
        
    }
}

// MARK: - Extensions
extension HomeViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // let tableViewCell = cell as? TableViewCell else { return }
    }
    
}
extension HomeViewController  : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0 && indexPath.row == 0 ){
            return 400

        }else {
            return 200
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! HomeTableViewCell
        
        cell.collectionViewHome.delegate = self
        cell.collectionViewHome.dataSource = self
        
        
        return cell
    }
}

extension HomeViewController : UICollectionViewDelegate{
    
}
extension HomeViewController : UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        collectionCell.layer.cornerRadius = 10
        collectionCell.layer.masksToBounds = true
        
        //        let url =  URL ( string : "https://assets.papelpop.com/wp-content/uploads/2019/07/Captura-de-Tela-2019-07-25-a%CC%80s-15.09.53.png " )
        //        collectionCell.imageViewHome.kf.setImage (with: url)
        collectionCell.backgroundColor = model[collectionView.tag][indexPath.row]
        return collectionCell
    }
    
    
}
//extension HomeViewController: UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if(indexPath.section == 0){
//            return CGSize(width: 50, height: 50)
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
