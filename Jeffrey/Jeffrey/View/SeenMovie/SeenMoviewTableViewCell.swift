//
//  SeenMoviewTableViewCell.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 22/11/20.
//

import UIKit

class SeenMoviewTableViewCell: UITableViewCell {
    
    @IBOutlet var imageMovie:UIImageView!
    @IBOutlet var labelNameMovie: UILabel!
    @IBOutlet var labelGenres: UILabel!
    
    func setup(movie: Movie){
        let idImage =  movie.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
        let data = try? Data(contentsOf: url!)
        imageMovie.image = UIImage(data: data!)!
        
        
        labelNameMovie.text = movie.title
        
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
