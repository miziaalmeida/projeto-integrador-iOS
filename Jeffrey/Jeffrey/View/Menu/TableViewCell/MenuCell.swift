//
//  MenuTableViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 23/11/20.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageViewMenu: UIImageView!
  

    func setup(menu: Menu) {
        labelName.text = menu.name
        imageViewMenu.image = UIImage(named: menu.image)
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
