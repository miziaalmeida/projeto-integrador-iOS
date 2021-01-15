import UIKit
import Firebase
import FirebaseDatabase

protocol RegisterViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private var viewModel: RegisterViewModelProtocol?
    
    let usuario = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(button: registerButton)
        
        configureTextFieldDelegate()
        
        self.viewModel = RegisterViewModel()
        self.viewModel?.viewController = self
    }
    
    
    @IBAction func register(_ sender: Any) {
        viewModel?.registerTapped()
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { authResult, error in
                let credential = EmailAuthProvider.credential(withEmail: self.nameTextField.text ?? "", password: self.passwordTextField.text ?? "")
        }
//        Auth.auth().createUser(withEmail: emailTextField.text, password: password) { authResult, error in
//                    // [START_EXCLUDE]
//                    strongSelf.hideSpinner {
//                      guard let user = authResult?.user, error == nil else {
//                        strongSelf.showMessagePrompt(error!.localizedDescription)
//                        return
//                      }
//                      print("\(user.email!) created")
//                      strongSelf.navigationController?.popViewController(animated: true)
//                    }
//                    // [END_EXCLUDE]
//                  }
        
        clearTextFields()
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel?.loginTapped()
    }
    
    func configureTextFieldDelegate(){
        nameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    func setupButton(button: UIButton){
        button.backgroundColor = .red
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    func clearTextFields(){
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}

extension RegisterViewController: RegisterViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}

extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIViewController {
    class func replaceRootViewController(viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
        else {
            return
        }
        let rootViewController = window.rootViewController!
        viewController.view.frame = rootViewController.view.frame
        viewController.view.layoutIfNeeded()
        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
}
