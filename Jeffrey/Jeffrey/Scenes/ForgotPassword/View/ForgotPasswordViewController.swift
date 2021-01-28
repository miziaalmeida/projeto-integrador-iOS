import UIKit
import Firebase

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
        viewModel?.sendTapped()
        clearTextFields()
    }
    
    
    @IBAction func login(_ sender: Any) {
        viewModel?.loginTapped()
    }
    
    func setupButton(button: UIButton){
        button.backgroundColor = .red
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
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
