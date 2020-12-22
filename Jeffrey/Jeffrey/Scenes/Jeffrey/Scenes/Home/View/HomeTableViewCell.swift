//
//  HomeTableViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var labelGenero: UILabel!
    @IBOutlet weak var collectionViewHome : UICollectionView!
    
    var arrayMovie = [MenuMovie]()
    
    static let identifier = "tableCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    
   
    
    public func configure(with movie: [MenuMovie]){
        self.arrayMovie = movie
            collectionViewHome.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
