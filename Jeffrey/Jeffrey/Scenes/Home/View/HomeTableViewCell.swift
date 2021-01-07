//
//  HomeTableViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    // MARK: Outlets
    
    
    @IBOutlet weak var collectionViewHome : UICollectionView!
    
    var arrayImage = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionViewHome.delegate = self
        self.collectionViewHome.dataSource = self
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell
        {
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
   }
    

}


