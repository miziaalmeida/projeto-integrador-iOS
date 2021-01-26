//
//  LoginEmailViewController.swift
//  Jeffrey
//
//  Created by Mizia Lima on 1/25/21.
//


import Firebase
import UIKit






class LoginEmailViewController: UIViewController{
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        view.endEditing(true)
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                }else{
                    guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                                bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
                    
                    self.navigationController?.pushViewController(homeViewControler, animated: true)
                    
                }
            }
        }
        
        self.clearTextFields()
        
    }
    
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        if let forgotPassView = UIStoryboard(name: "ForgotPassword", bundle: nil).instantiateInitialViewController() as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(forgotPassView, animated: true)
        }
    }
    
    
    
    func clearTextFields(){
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
}
