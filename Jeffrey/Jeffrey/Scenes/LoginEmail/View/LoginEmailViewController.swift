//
//  LoginEmailViewController.swift
//  Jeffrey
//
//  Created by Mizia Lima on 1/25/21.
//
import Firebase
import UIKit
import ProgressHUD

protocol LoginEmailViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class LoginEmailViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var viewModel: LoginEmailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = LoginEmailViewModel()
        self.viewModel?.viewController = self
        
        configButton(button: signInButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configNavigationItem()
    
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func signInTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.validateFields()
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else{
                    self.viewModel?.signInTapped()
                    //                    guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                    //                                                                bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
                    //
                    //                    self.navigationController?.pushViewController(homeViewControler, animated: true)
                }
            }
        }
        self.clearTextFields()
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        viewModel?.forgotPasswordTap()
    }
    
    func validateFields() {
        guard let email = emailTextField.text, !email.isEmpty else {
            ProgressHUD.showError("Por favor entre com um email")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            ProgressHUD.showError("Por favor entre com uma senha")
            return
        }
    }
    
    func clearTextFields(){
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func configButton(button: UIButton){
        button.backgroundColor = UIColor.red.withAlphaComponent(1.0)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    func configNavigationItem(){
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension LoginEmailViewController: LoginEmailViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
