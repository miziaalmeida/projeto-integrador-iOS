//
//  CollectionTableViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 20/11/20.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var arrayMovie = [MenuMovie]()
    
    static let identifier = "CollectionTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
    public func configure(with movie: [MenuMovie]){
        self.arrayMovie = movie
        myCollectionView.reloadData()
    }
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myCollectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.layer.borderColor = UIColor.gray.cgColor
        myCollectionView.layer.borderWidth = 1.0
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
}
  
}
extension CollectionTableViewCell : UICollectionViewDelegate{
    
}
extension CollectionTableViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
            cell.configure(with: arrayMovie[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0{
            return CGSize(width: 800, height: 400)
                }
        return CGSize(width: 200, height: 200)
        
    }
    
}
//extension CollectionTableViewCell : UICollectionViewDelegateFlowLayout{
//
//}

