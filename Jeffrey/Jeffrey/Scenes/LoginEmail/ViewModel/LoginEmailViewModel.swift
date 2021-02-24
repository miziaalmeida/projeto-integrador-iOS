import UIKit
import ProgressHUD

//MARK: PROTOCOL VIEW MODEL
protocol LoginEmailViewModelProtocol: AnyObject{
    func validateSignInForLogin(email: String, password: String, view: UIView, viewController: UIViewController, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void)
    func didTapForgotPassword()
    func didTapRegisterAccount()
    func showHome()
    var viewController: LoginEmailViewEvents? {get set}
}

//MARK: VIEW MODEL
class LoginEmailViewModel: LoginEmailViewModelProtocol {
    weak var viewController: LoginEmailViewEvents?
    var activityIndicator = ActivityIndicatorViewController()
    
    func showHome() {
        guard let homeViewControler = UIStoryboard(name: "HomeMain",
                                                   bundle: nil).instantiateInitialViewController() as? UITabBarController else {return}
        
        UIViewController.replaceRootViewController(viewController: homeViewControler)
    }
    
    func didTapForgotPassword() {
        guard let forgotPassView = UIStoryboard(name: "ForgotPassword",
                                                bundle: nil).instantiateInitialViewController() as? ForgotPasswordViewController else { return }
        viewController?.present(viewController: forgotPassView)
    }
    
    func didTapRegisterAccount() {
        guard let registerView = UIStoryboard(name: "Register",
                                              bundle: nil).instantiateInitialViewController() as? RegisterViewController  else { return }
        viewController?.push(viewController: registerView)
    }
    
    func validateSignInForLogin(email: String, password: String, view: UIView, viewController: UIViewController, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        AuthUser.User.validateSignIn(email: email , password: password, view: view, viewController: viewController) {
            onSucess()
        } onError: { (errorMessage) in
            onError(errorMessage)
        }
    }
}
