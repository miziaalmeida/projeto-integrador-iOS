import UIKit

//MARK: PROTOCOL VIEW MODEL
protocol LoginViewModelProtocol: AnyObject{
    func didTapLoginWithEmail()
    func didTapRegisterAccount()
    func didTapGoogleLogin(viewController: UIViewController)
    func didTapFacebookLogin(viewController: UIViewController)
    var viewController: LoginViewEvents? {get set}
}

//MARK: VIEW MODEL
class LoginViewModel: LoginViewModelProtocol{
    weak var viewController: LoginViewEvents?
    
    func didTapLoginWithEmail(){
        guard let loginEmailView = UIStoryboard(name: "LoginEmail",
                                                bundle: nil).instantiateInitialViewController()
                as? LoginEmailViewController  else { return }
        viewController?.push(viewController: loginEmailView)
    }
    
    
    func didTapRegisterAccount() {
        guard let registerView = UIStoryboard(name: "Register",
                                              bundle: nil).instantiateInitialViewController()
                as? RegisterViewController  else { return }
        viewController?.push(viewController: registerView)
    }
    
    func didTapGoogleLogin(viewController: UIViewController) {
        AuthUser.User.signInWithGoogle(viewController: viewController)
    }
    
    func didTapFacebookLogin(viewController: UIViewController) {
        AuthUser.User.signInWithFacebook(viewController: viewController)
    }
}
