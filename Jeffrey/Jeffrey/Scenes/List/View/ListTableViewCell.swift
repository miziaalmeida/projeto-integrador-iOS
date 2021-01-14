//
//  ListTableViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 06/01/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var labelMovieName: UILabel!
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var labelDateRelease: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(movie: Movie){
        
        if let idImage = movie.backdropPath{
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage)")
            let data = try? Data(contentsOf: url!)
            imageMovie.image = UIImage(data: data!)
            labelMovieName.text = movie.title
            labelDateRelease.text = movie.releaseDate
      
            imageMovie.clipsToBounds = true
            imageMovie.layer.cornerRadius = 20.0
            
        }
        
        
    }
    
}
