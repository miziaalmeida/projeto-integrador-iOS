//
//  MyCollectionViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 20/11/20.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "MyCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    public func configure(with movie: Movie){
        self.imageView.image = UIImage(named: movie.myImage)
    }
    
    var arrayMovie = [Movie]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let url = URL(string: "https://example.com/image.png")
//        imageView.kf.setImage(with: url)
        
    }

}
