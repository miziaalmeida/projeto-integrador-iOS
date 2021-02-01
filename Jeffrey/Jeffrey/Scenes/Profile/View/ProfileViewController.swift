import UIKit
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin

class ProfileViewController: UIViewController{

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var showImagePicker: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    
    var imagePicker: ImagePicker!
    private var viewModel: ProfileViewModelProtocol?
    //var sections = ["Editar Perfil", "Sair da conta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
        self.viewModel = ProfileViewModel()
        
        view1.backgroundColor = UIColor.clear
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        customButtons(button: editProfileBtn, title: "Editar Perfil")
        customButtons(button: exitBtn, title: "Sair da conta")
        
        customImage()
        nameLabel.text = "Oi Ariana!"
    }
    
    @IBAction func showImagePicker(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIButton)
    }
    
    @IBAction func tapEditProfile(_ sender: Any) {
        viewModel?.didTapEditProfile(controller: self)
        print("entrou")
    }
    
    @IBAction func tapExitAccount(_ sender: Any) {
        viewModel?.didTapExitAccount(controller: self)
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            loginManager.logOut()
            print("~ Deu Logout no facebook!! ~")
        }
        
        do {
            try Auth.auth().signOut()
            print("Deu Logout no Email")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
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
    
    func customImage(){
        profilePhoto.layer.cornerRadius = 20
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderColor = UIColor.clear.cgColor
    }
}

extension ProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.profilePhoto.image = image
    }
}
