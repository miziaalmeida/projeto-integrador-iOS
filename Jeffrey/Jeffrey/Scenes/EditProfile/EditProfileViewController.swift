import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var alterName: UIButton!
    @IBOutlet weak var alterPassword: UIButton!
    @IBOutlet weak var deleteAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    func customButtons(button: UIButton, title: String){
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0

        //button.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        button.layer.cornerRadius = cornerRadius
    }
}
