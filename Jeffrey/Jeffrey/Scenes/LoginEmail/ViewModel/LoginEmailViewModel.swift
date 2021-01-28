import Foundation
import UIKit

protocol LoginEmailViewModelProtocol: AnyObject{
    func signInTapped()
    func forgotPasswordTap()
    func registerTap()
    var viewController: LoginEmailViewEvents? {get set}
}

class LoginEmailViewModel: LoginEmailViewModelProtocol{
    weak var viewController: LoginEmailViewEvents?
    
    
    func signInTapped() {
        guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                    bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
        viewController?.push(viewController: homeViewControler)
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
}
