import UIKit

class ProfileDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionLabel: UILabel!
    
    var sections = ["Editar Perfil", "Sair da conta"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
