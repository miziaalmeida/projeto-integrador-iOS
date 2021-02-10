import UIKit
import Firebase
import ProgressHUD

protocol ForgotPasswordViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var backLoginButton: UIButton!
    
    private var viewModel: ForgotPasswordViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationItem()
        
        setupButton(button: sendButton)
        
        configureTextFieldDelegate()
        
        self.viewModel = ForgotPasswordViewModel()
        self.viewModel?.viewController = self
        
    }
    
    @IBAction func send(_ sender: Any) {
        viewModel?.resetPassDidTapped()
        self.resetPassword()
    }
    
    
    @IBAction func login(_ sender: Any) {
        viewModel?.loginTapped()
    }
    
    func setupButton(button: UIButton){
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.backgroundColor = UIColor.white.withAlphaComponent(1.0)
            button.tintColor = UIColor.black
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
        }
    
    func resetPassword(){
        guard let email = emailTextField.text, email != " " else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL_RESET)
            return
        }
        AuthUser.User.resetPassword(withEmail: email, onSucess: {
            self.view.endEditing(true)
            self.clearTextFields()
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
     
    func clearTextFields(){
        emailTextField.text = ""
    }
    
    func configureTextFieldDelegate(){
        emailTextField.delegate = self
    }
    
    func configNavigationItem(){
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewEvents{
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
