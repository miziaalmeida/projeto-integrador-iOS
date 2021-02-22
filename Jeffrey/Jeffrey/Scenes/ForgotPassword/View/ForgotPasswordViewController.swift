import UIKit
import Firebase
import ProgressHUD

//MARK: PROTOCOL EVENTS
protocol ForgotPasswordViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

//MARK: VIEW CONTROLLER
class ForgotPasswordViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var backLoginButton: UIButton!
    
    private var viewModel: ForgotPasswordViewModelProtocol?
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureButton(button: sendButton)
        configureTextFieldDelegate()
        
        self.viewModel = ForgotPasswordViewModel()
        self.viewModel?.viewController = self
        
    }
    
    //MARK: ACTIONS
    @IBAction func send(_ sender: Any) {
        self.validateEmailField()
        view.endEditing(true)
    }
    
    
    @IBAction func login(_ sender: Any) {
        viewModel?.didTapLogin()
    }
    
    func validateEmailField(){
        let email = emailTextField.text
        
        if email == "" {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL_RESET)
            return
        } else {
            viewModel?.validateEmailField(email: emailTextField.text!, view: view)
            self.clearTextFields()
        }
    }
    
    func configureButton(button: UIButton){
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        button.tintColor = UIColor.black
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    func configureTextFieldDelegate(){
        emailTextField.delegate = self
    }
    
    func configureNavigationItem(){
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func clearTextFields(){
        emailTextField.text = ""
    }
}

//MARK: EXTENSIONS
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
