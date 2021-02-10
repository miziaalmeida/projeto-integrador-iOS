import Foundation
import UIKit
import Firebase
import UIKit
import Firebase
import ProgressHUD

protocol LoginEmailViewModelProtocol: AnyObject{
    func validateSignIn(email: String, password: String, view: UIView, viewController: UIViewController, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void)
    func forgotPasswordTap()
    func registerTap()
    var viewController: LoginEmailViewEvents? {get set}
}

class LoginEmailViewModel: LoginEmailViewModelProtocol {
    weak var viewController: LoginEmailViewEvents?
    var activityIndicator = ActivityIndicatorViewController()
    
    
    func signInTapped() {
        guard let homeViewControler = UIStoryboard(name: "HomeMain",
                                                   bundle: nil).instantiateInitialViewController() as? UITabBarController else {return}
          
        UIViewController.replaceRootViewController(viewController: homeViewControler)
    }
    
    func forgotPasswordTap() {
        guard let forgotPassView = UIStoryboard(name: "ForgotPassword",
                                                bundle: nil).instantiateInitialViewController() as? ForgotPasswordViewController else { return }
        viewController?.push(viewController: forgotPassView)
    }
    
    func registerTap() {
        guard let registerView = UIStoryboard(name: "Register",
                                              bundle: nil).instantiateInitialViewController() as? RegisterViewController  else { return }
        viewController?.push(viewController: registerView)
    }
    
    func messageUser(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(actionCancel)
        viewController!.present(viewController: alert)
        
    }
    
    func validateSignIn(email: String, password: String, view: UIView, viewController: UIViewController, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                
                if user == nil{
                    self.messageUser(title: "Erro ao autenticar", message: "Senha ou E-mail inválidos, tente novamente.")
                }else{
                    self.signInTapped()
                  }
            }else{
                self.messageUser(title: "Dados Inválidos", message: "Senha ou E-mail inválidos, tente novamente.")
            }
          }
    }
}
