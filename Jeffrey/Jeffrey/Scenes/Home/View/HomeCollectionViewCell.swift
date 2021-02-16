//
//  HomeCollectionViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
   @IBOutlet weak var imageViewHome: UIImageView!
   @IBOutlet weak var labelTitleViewHome: UILabel!
    
        override func awakeFromNib() {
            super.awakeFromNib()
        }
    
    func setup(movie:Movie){
        if let idImage =  movie.backdropPath{
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage)")
            let data = try? Data(contentsOf: url!)
            imageViewHome.image = UIImage(data: data!)
            labelTitleViewHome.text = movie.title
        }
        
    }

}
