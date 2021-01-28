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
            ProgressHUD.showError("Por favor preencha o campo de nome")
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            ProgressHUD.showError("Por favor preencha o campo de email")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            ProgressHUD.showError("Por favor preencha com sua senha")
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
        self.signUp()
        
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
    
    func signUp(){
        guard let imageSelected = self.image else {
            ProgressHUD.showError("Por favor escolha uma foto")
            return
        }
        AuthUser.User.signUp(withUsername: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, image: self.image,
            onSucess: {
                print("Foi")
            }){ (errorMessage) in
            print(errorMessage)
        }
        self.viewModel?.registerTapped()
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
