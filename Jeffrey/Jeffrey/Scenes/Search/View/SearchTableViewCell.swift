//
//  SearchTableViewCell.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 05/01/21.
//

import UIKit
import CoreData

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet var imageMovie:UIImageView!
    @IBOutlet var labelnameMovie:UILabel!
    @IBOutlet var labelRelease:UILabel!
    
    @IBOutlet weak var labelVoteAverage: UILabel!
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
            let dataRelease = formatDate(date: movie.releaseDate)
            labelRelease.text = dataRelease
            labelVoteAverage.text = String(movie.voteAverage)
            imageMovie.clipsToBounds = true
            imageMovie.layer.cornerRadius = 20.0
        }
    }
    
    func formatDate(date:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        let date: NSDate? = dateFormatterGet.date(from: String(date)) as NSDate?
        return dateFormatterPrint.string(from: date! as Date)
    }
}
