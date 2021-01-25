import Foundation
import UIKit

protocol LoginViewModelProtocol: AnyObject{
    func loginEmail()
    func registerAccount()
    func openHome()
    func googleLogin()
    func appleLogin()
    func facebookLogin()
    var viewController: LoginViewEvents? {get set}
}

class LoginViewModel: LoginViewModelProtocol{
    weak var viewController: LoginViewEvents?
    
    func loginEmail(){
        guard let loginEmailView = UIStoryboard(name: "LoginEmail",
                                                bundle: nil).instantiateInitialViewController()
                as? LoginEmailViewController  else { return }
        viewController?.push(viewController: loginEmailView)
    }
    
    
    func registerAccount() {
        guard let registerView = UIStoryboard(name: "Register",
                                              bundle: nil).instantiateInitialViewController()
                as? RegisterViewController  else { return }
        viewController?.push(viewController: registerView)
    }
    
    func openHome(){
        guard let homeView = UIStoryboard(name: "HomeMain",
                                              bundle: nil).instantiateInitialViewController()
                as? UITabBarController  else { return }
        viewController?.push(viewController: homeView)
    }
    
    func googleLogin() {
        
    }
    
    func appleLogin() {
        //abrir login via apple
    }
    
    func facebookLogin() {
        //abir login via facebook
    }
}
