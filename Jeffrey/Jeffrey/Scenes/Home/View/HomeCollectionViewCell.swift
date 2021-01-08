//
//  HomeCollectionViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
   @IBOutlet weak var imageViewHome: UIImageView!
        

        
        override func awakeFromNib() {
            super.awakeFromNib()
//            imageViewHome.kf.indicatorType = .activity
////            imageViewHome.kf.setImage(with: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Skyshot.jpg/220px-Skyshot.jpg"), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
//
//            let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Skyshot.jpg/220px-Skyshot.jpg")
//            imageViewHome.kf.setImage(with: url)
        }
    
    
    func setup(movie:Movie){
        let idImage =  movie.backdropPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
        let data = try? Data(contentsOf: url!)
        imageViewHome.image = UIImage(data: data!)
    }

}
