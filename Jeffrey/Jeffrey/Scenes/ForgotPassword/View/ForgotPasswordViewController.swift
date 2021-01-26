import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var backLoginButton: UIButton!
    
    private var viewModel: ForgotPasswordViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(button: sendButton)
        
        configureTextFieldDelegate()
        
        self.viewModel = ForgotPasswordViewModel()

    }
    
    @IBAction func send(_ sender: Any) {
        viewModel?.sendTapped(controller: self)
        
        let alert = UIAlertController(title: "Email enviado com sucesso!", message: "Seu email foi enviado com sucesso, verifique sua caixa de entrada.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        clearTextFields()
    }
    
    
    @IBAction func login(_ sender: Any) {
        viewModel?.loginTapped(controller: self)
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
}

extension ForgotPasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
