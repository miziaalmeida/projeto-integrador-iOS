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
    
    func validateSignIn(email: String, password: String, view: UIView, viewController: UIViewController, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        
        if signInTapped() != nil{
               AuthUser.User.signIn(withEmail: email, password: password,
                             onSucess: {
                                self.activityIndicator.showActivityIndicator(view: view, targetVC: viewController)
                                onSucess()
                                DispatchQueue.main.async {
                                    self.activityIndicator.hideActivityIndicator(view: view)
                                }
                             } ) { (errorMessage) in
                                    onError(errorMessage)
           }
        } else {
            let alert = UIAlertController(title: "Error", message: "Dados Inválidos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
      }
    }
