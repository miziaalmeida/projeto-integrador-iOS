//
//  HomeViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit
import Kingfisher



class HomeViewController: UIViewController {
    
    let imageURL = [
        "https://i.ytimg.com/vi/I6Gj8Fvukk4/maxresdefault.jpg",
        "https://i.ytimg.com/vi/I6Gj8Fvukk4/maxresdefault.jpg",
        "https://i.ytimg.com/vi/I6Gj8Fvukk4/maxresdefault.jpg",
        "https://i.ytimg.com/vi/I6Gj8Fvukk4/maxresdefault.jpg",
        "https://i.ytimg.com/vi/I6Gj8Fvukk4/maxresdefault.jpg"
    ]
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableViewHome:UITableView!
    
    
    
    
    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.estimatedRowHeight = 44.0
        tableViewHome.rowHeight = UITableView.automaticDimension
       
        
        
    }
}

// MARK: - Extensions
extension HomeViewController : UITableViewDelegate{
    
}
extension HomeViewController  : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0 ){
            return 400
        }else{
            return 200
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURL.count
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
        return imageURL.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        collectionCell.layer.cornerRadius = 10
        collectionCell.layer.masksToBounds = true
        let imageView = UIImageView()
        collectionCell.addSubview(imageView)
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: collectionCell.leadingAnchor, constant: 5).isActive = true
        imageView.trailingAnchor.constraint(equalTo: collectionCell.trailingAnchor, constant: -5).isActive = true
        imageView.topAnchor.constraint(equalTo: collectionCell.topAnchor, constant: 5).isActive = true
        imageView.bottomAnchor.constraint(equalTo: collectionCell.bottomAnchor, constant: 5).isActive = true
        
        imageView.kf.setImage(with: URL(string: imageURL[indexPath.row]))
    
        return collectionCell
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.section == 0){
            return CGSize(width: 150, height: 300)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
