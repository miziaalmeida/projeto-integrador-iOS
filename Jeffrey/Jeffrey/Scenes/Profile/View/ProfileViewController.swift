import UIKit

protocol ProfileViewEvents: AnyObject {
    func push(viewController: UIViewController)
    func present(viewController: UIViewController)
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var exitAccount: UIButton!
    @IBOutlet weak var deleteAccount: UIButton!
    
    private var viewModel: ProfileViewModelProtocol?
    
    var nameUser = ""
    var emailUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ProfileViewModel()
        self.viewModel?.viewController = self

        nameLabel.text = nameUser
        emailLabel.text = emailUser
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Profile" {
            let destView = segue.destination as! ProfileViewController
            destView.nameUser = self.nameUser
            destView.emailUser = self.emailUser
        }
    }
    
    @IBAction func edit(_ sender: Any) {
    }
    
    @IBAction func exit(_ sender: Any) {
        viewModel?.didTapExitAccount()
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
    }
}

extension ProfileViewController: ProfileViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
