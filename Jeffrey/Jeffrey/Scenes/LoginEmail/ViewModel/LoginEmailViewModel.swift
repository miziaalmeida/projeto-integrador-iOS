import Foundation
import UIKit

protocol LoginEmailViewModelProtocol: AnyObject{
    func signInTapped() -> UIViewController
    func forgotPasswordTap()
    func registerTap()
    var viewController: LoginEmailViewEvents? {get set}
}

class LoginEmailViewModel: LoginEmailViewModelProtocol {
    weak var viewController: LoginEmailViewEvents?
    
    
    func signInTapped() -> UIViewController{
        let homeViewControler = UIStoryboard(name: "HomeMain",
                                                    bundle: nil).instantiateInitialViewController() as? UITabBarController 
        return homeViewControler!
        
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
    
//    class func replaceRootViewController(viewController: UIViewController) {
//        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
//        else {
//            return
//        }
//        let rootViewController = window.rootViewController!
//        viewController.view.frame = rootViewController.view.frame
//        viewController.view.layoutIfNeeded()
//        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft, animations: {
//            window.rootViewController = viewController
//        }, completion: nil)
//    }
    
}
