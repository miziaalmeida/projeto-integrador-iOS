import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import ProgressHUD

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
    @IBOutlet weak var avatar: UIImageView!
    
    private var viewModel: RegisterViewModelProtocol?
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton(button: registerButton)
        configNavigationItem()
        configureTextFieldDelegate()
        configAvatar()
        
        self.viewModel = RegisterViewModel()
        self.viewModel?.viewController = self
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func validateFields() {
        guard let name = nameTextField.text, !name.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
        guard let confirmPass = confirmPasswordTextField.text, !confirmPass.isEmpty else {
            ProgressHUD.showError("Por favor confirme sua senha")
            return
        }
    }
    
    @IBAction func register(_ sender: Any) {
        self.view.endEditing(true)
        self.validateFields()
        self.signUp(onSucess: {
            print("Foi")
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel?.loginTapped()
    }
    
    func configAvatar(){
        avatar.frame = CGRect(x: 10, y: 10, width: 100, height: 100);
        avatar.layer.cornerRadius = 50.0;
        avatar.layer.masksToBounds = true;
        // avatar.layer.cornerRadius = avatar.frame.size.width/2.0
        avatar.layer.borderColor = UIColor.lightGray.cgColor
        avatar.layer.borderWidth = 0.2
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPickerImageView))
        avatar.addGestureRecognizer(tapGesture)
    }
    
    @objc func presentPickerImageView(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        // picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
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
    
    func configNavigationItem(){
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func signUp(onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        ProgressHUD.show()
        AuthUser.User.signUp(withUsername: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, image: self.image,
                             onSucess: {
                                ProgressHUD.dismiss()
                                self.viewModel?.registerTapped()
                                onSucess()
                             }) { (errorMessage) in
            onError(errorMessage)
        }
        clearTextFields()
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            avatar.image = imageSelected
        }
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            avatar.image = imageOriginal
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
