import UIKit

enum Options {
    static let user = 0
    static let password = 1
}

var person: User?

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var insertNameLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var insertEmailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            print("Entrou 0")
            
        case 1:
            print("Entrou 1")
        default:
            break
        }
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        let vc = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as? ViewController)!
        present(vc, animated: true, completion: nil)
    }
}
