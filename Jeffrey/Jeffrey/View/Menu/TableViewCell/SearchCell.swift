//
//  SearchCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 23/11/20.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var imageViewMenu : UIImageView!
    @IBOutlet weak var labelTitle : UILabel!
    

    func setup(search: Search) {
        labelTitle.text = search.nameTitle
        imageViewMenu.image = UIImage(named: search.imageView)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
