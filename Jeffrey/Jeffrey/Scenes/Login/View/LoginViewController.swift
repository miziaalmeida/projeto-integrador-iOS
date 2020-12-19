import UIKit
import TextFieldEffects

class LoginViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel: LoginViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldsDelegate()
        configureTextField(textField: emailTextField)
        configureTextField(textField: passwordTextField)
        
        setupButton(button: signInButton)
        
        setupButtonSocialMedia(button: googleButton)
        setupButtonSocialMedia(button: facebookButton)
        setupButtonSocialMedia(button: appleButton)
        
        label.text = "Olá \nPronto para logar?"
        
        self.viewModel = LoginViewModel()
        
}
    
    
    @IBAction func signInTapped(_ sender: Any) {
        view.endEditing(true)
        clearTextFields()
        alertProvisorioLogin()
    }
    
    @IBAction func googleTapped(_ sender: Any) {
        viewModel?.googleTap(controller: self)
        print("Entrou google")
    }
    
    @IBAction func facebookTapped(_ sender: Any) {
        viewModel?.facebookTap(controller: self)
        print("Entrou facebook")
    }
    
    @IBAction func appleTapped(_ sender: Any) {
        viewModel?.appleTap(controller: self)
        print("Entrou apple")
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        viewModel?.forgotPasswordTap(controller: self)
    }
    
    
    @IBAction func registerTapped(_ sender: Any) {
        viewModel?.registerTap(controller: self)
    }
    
    private func configureTextFieldsDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func configureTextField(textField: UITextField){
        textField.backgroundColor = UIColor.clear
    }
    
    func clearTextFields(){
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func alertProvisorioLogin(){
        let alert = UIAlertController(title: "Login realizado com sucesso!", message: "Seja bem vindo ao Jeffrey!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
//        viewModel?.signInTapped(controller: self)
    }
    
    func setupButton(button: UIButton){
        button.backgroundColor = .red
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    func setupButtonSocialMedia(button: UIButton){
        button.layer.cornerRadius = button.frame.width / 2
        let image = button.currentImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
