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
    @IBOutlet weak var labelVoteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(movie: Movie){
        let dataRelease = formatDate(date: movie.releaseDate)
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath!)")
            let data = try? Data(contentsOf: url!)
            imageMovie.image = UIImage(data: data!)
            labelMovieName.text = movie.title
            labelDateRelease.text = dataRelease
            labelVoteAverage.text = String(movie.voteAverage)
            imageMovie.clipsToBounds = true
            imageMovie.layer.cornerRadius = 20.0
            
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


