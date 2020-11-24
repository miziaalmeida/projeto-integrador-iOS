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
    var arrayMovie = [MenuMovie]()
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    public func configure(with movie: MenuMovie){
        self.imageView.image = UIImage(named: movie.myImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let url = URL(string: "https://example.com/image.png")
//        imageView.kf.setImage(with: url)
        
    }

}
