//
//  SearchTableViewCell.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet var imageMovie:UIImageView!
    @IBOutlet var labelnameMovie:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(movie:Movie){
        if let idImage = movie.backdropPath{
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage)")
            let data = try? Data(contentsOf: url!)
            imageMovie.image = UIImage(data: data!)
            labelnameMovie.text = movie.title
            print(movie.title)
            print(movie.id)
            
           
            imageMovie.clipsToBounds = true
            imageMovie.layer.cornerRadius = 20.0
            
        }
       
        
        
    }

}
