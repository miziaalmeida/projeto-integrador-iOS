import Foundation
import UIKit

protocol LoginViewModelProtocol: AnyObject{
        func signInTapped()
        func googleTap(controller: UIViewController)
        func appleTap(controller: UIViewController)
        func facebookTap(controller: UIViewController)
        func forgotPasswordTap(controller: UIViewController)
        func registerTap(controller: UIViewController)
        var viewController: LoginViewEvents? {get set}
}

class LoginViewModel: LoginViewModelProtocol{
    weak var viewController: LoginViewEvents?

    func signInTapped() {
        guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                    bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
        
        viewController?.push(viewController: homeViewControler)
    }
    
    func googleTap(controller: UIViewController) {
        //abrir login google
        
    }
    
    func appleTap(controller: UIViewController) {
        //abrir login via apple
    }
    
    func facebookTap(controller: UIViewController) {
        //abir login via facebook
    }
    
    func forgotPasswordTap(controller: UIViewController) {
        if let forgotPassView = UIStoryboard(name: "ForgotPassword", bundle: nil).instantiateInitialViewController() as? ForgotPasswordViewController {
            controller.navigationController?.pushViewController(forgotPassView, animated: true)
        }
    }
    
    func registerTap(controller: UIViewController) {
        if let registerView = UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as? RegisterViewController {
            controller.navigationController?.pushViewController(registerView, animated: true)
        }
    }
}
