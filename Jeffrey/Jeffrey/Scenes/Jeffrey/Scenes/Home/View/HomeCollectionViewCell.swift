//
//  HomeCollectionViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
  //  @IBOutlet weak var imageViewHome: UIImageView!
        
        static let identifier = "collectionCell"
        var arrayMovie = [MenuMovie]()
        
        static func nib() -> UINib{
            return UINib(nibName: "MyCollectionViewCell", bundle: nil)
        }
        
//        public func configure(with movie: MenuMovie){
//            self.imageViewHome.image = UIImage(named: movie.myImage)
//            self.imageViewHome.contentMode = .scaleAspectFit
//
//     }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            

    //        let url = URL(string: "https://example.com/image.png")
    //        imageView.kf.setImage(with: url)

        }

}
